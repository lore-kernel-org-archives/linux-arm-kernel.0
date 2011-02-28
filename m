From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 28 Feb 2011 20:19:33 +0100
Subject: [patch 1/2] mc13892: reboot on wdi event
In-Reply-To: <20110228181145.GA27231@opensource.wolfsonmicro.com> (Mark
	Brown's message of "Mon, 28 Feb 2011 18:11:45 +0000")
References: <20110228132132.654689676@rtp-net.org>
	<20110228132643.964403175@rtp-net.org>
	<20110228143552.GC13869@opensource.wolfsonmicro.com>
	<87k4gkyydi.fsf@lebrac.rtp-net.org>
	<20110228181145.GA27231@opensource.wolfsonmicro.com>
Message-ID: <877hckynju.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Mon, Feb 28, 2011 at 04:25:45PM +0100, Arnaud Patard wrote:
>
>> afaik, mc13892 is used only on imx designs and the reset for imx is done
>> only throught the watchdog. From this point of view,  I don't see any
>> valid reason for powering off instead of rebooting on watchdog event
>
> Is there a separate way to do power off?

yeah. You can either disable pwgt1 and pwgt2 regulators or set the
useroff bit of the power control 0 register.

Arnaud
