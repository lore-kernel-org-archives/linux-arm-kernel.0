From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 19 Aug 2011 15:00:06 +0800
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
	selection
In-Reply-To: <20110819063533.GR31404@pengutronix.de>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
	<20110819063533.GR31404@pengutronix.de>
Message-ID: <20110819070005.GD12527@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 08:35:33AM +0200, Sascha Hauer wrote:
> On Fri, Aug 19, 2011 at 12:56:59PM +0800, Shawn Guo wrote:
> > Now that the DEBUG_LL UART can be selected by a Kconfig choice,
> > simplify the #ifdefery in debug-macro.S and add entries to the
> > top-level Kconfig.debug instead.
> 
> I'm unsure whether I like this. The ifdeffery does not look very good,

It does not make the code any worse.  Instead, the ifdeffery becomes
shorter actually.

> but the Kconfig snippet is not shorter, also it is in generic arm code
> and not i.MX specific.

This comment is on the whole approach proposed by Will, I guess. But
I did not see any better alternatives until we can have device tree
into such a early boot stage, which is not possible for now. 

> The old way also makes sure that we do not
> compile in incompatible lowlevel debug code.
> At least this should be a choice in Kconfig to make clear that the
> different low-level debug options are exclusive.
> 
It is a choice.

-- 
Regards,
Shawn
