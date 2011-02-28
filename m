From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 28 Feb 2011 16:30:29 +0100
Subject: [patch 1/2] mc13892: reboot on wdi event
In-Reply-To: <20110228143740.GD13869@opensource.wolfsonmicro.com> (Mark
	Brown's message of "Mon, 28 Feb 2011 14:37:41 +0000")
References: <20110228132132.654689676@rtp-net.org>
	<20110228132643.964403175@rtp-net.org>
	<20110228143740.GD13869@opensource.wolfsonmicro.com>
Message-ID: <87fwr8yy5m.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Mon, Feb 28, 2011 at 02:21:33PM +0100, Arnaud Patard wrote:
>
>> +
>> +	/* allows to reboot on wdi event */
>> +	ret = mc13xxx_reg_read(mc13892, MC13892_POWERCTL2, &val);
>> +	if (!ret) {
>> +		val |= MC13892_POWERCTL2_WDIRESET;
>> +		mc13xxx_reg_write(mc13892, MC13892_POWERCTL2, val);
>> +	}
>> +
>
> Also, why is this in the regulator driver?  The MFD core for the device
> might be a better choice - that'll ensure it gets done even if regulator
> support isn't enabled for some reason.

I was not sure where to put it so I put it in the place where the power
management is done. I can move it to the mfd driver. I'll only have to
make sure it's done only for mc13892 (I don't know what would be the
consequences to do it on mc13783 too and if there's a similar
configuration setting).

Arnaud
