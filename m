From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 17 Mar 2011 09:29:03 +0100
Subject: [PATCHv3 3/3] ARM: mx51: Add support for low power suspend on MX51
In-Reply-To: <20110317082106.GT29521@pengutronix.de> (Sascha Hauer's message
	of "Thu, 17 Mar 2011 09:21:06 +0100")
References: <1300305787-7970-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1300305787-7970-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1300305787-7970-3-git-send-email-Dinh.Nguyen@freescale.com>
	<20110317082106.GT29521@pengutronix.de>
Message-ID: <87sjumrvzk.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

Hi,

> On Wed, Mar 16, 2011 at 03:03:07PM -0500, Dinh.Nguyen at freescale.com wrote:
>> +
>> +struct clk *gpc_dvfs_clk;
>> +
>> +static int mx5_suspend_enter(suspend_state_t state)
>> +{
>> +	if (gpc_dvfs_clk == NULL)
>> +		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs_clk");
>
> clk_get can fail and NULL can be a valid clock.

So, I guess one may want to fail here if one can't get the clock. The
suspend will fail in hard to debug way if this clock is not enabled
at this point.

Arnaud
