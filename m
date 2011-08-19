From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Aug 2011 12:09:41 +0100
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
	selection
In-Reply-To: <20110819063533.GR31404@pengutronix.de>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<1313729819-30301-1-git-send-email-shawn.guo@linaro.org>
	<20110819063533.GR31404@pengutronix.de>
Message-ID: <20110819110940.GC8918@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha,

On Fri, Aug 19, 2011 at 07:35:33AM +0100, Sascha Hauer wrote:
> On Fri, Aug 19, 2011 at 12:56:59PM +0800, Shawn Guo wrote:
> > Now that the DEBUG_LL UART can be selected by a Kconfig choice,
> > simplify the #ifdefery in debug-macro.S and add entries to the
> > top-level Kconfig.debug instead.
> 
> I'm unsure whether I like this. The ifdeffery does not look very good,
> but the Kconfig snippet is not shorter, also it is in generic arm code
> and not i.MX specific. The old way also makes sure that we do not
> compile in incompatible lowlevel debug code.

But it's an unfortunate hinderence to a single zImage kernel which we can
only solve sensibly in the generic ARM code.

> At least this should be a choice in Kconfig to make clear that the
> different low-level debug options are exclusive.

As Shawn pointed out, we are using a Kconfig choice so you can only select
one UART for low-level debug output.

Will
