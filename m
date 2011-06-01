From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Jun 2011 19:59:53 +0200
Subject: [PATCH 5/8 v2] ARM i.MX Allow to compile together i.MX1/21/25/27
In-Reply-To: <20110601164731.GI23771@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<201106011724.26704.arnd@arndb.de>
	<20110601164731.GI23771@pengutronix.de>
Message-ID: <201106011959.53679.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 June 2011 18:47:31 Sascha Hauer wrote:
> > 
> > Are you sure that this is actually the minimum set that is required?
> 
> I'd love to remove some of these, but I think they are required.
> SOC_SELECT_IMX1 and HAVE_SOC_IMX1 are only used to offer the right
> Kconfig magic.
> 
> > 
> > I assume that you have gone through all the uses of these symbols
> > to check that there is no silent breakage if you enable more than
> > one. The only ones that looks suspicious to me are
> > arch/arm/plat-mxc/include/mach/timex.h
> 
> See An earlier patch in this series. The ifdefs are removed and
> CLOCK_TICK_RATE is replaced with a bogus value. CLOCK_TICK_RATE
> is unused but still required to compile the kernel.
> 
> > and
> > arch/arm/plat-mxc/include/mach/debug-macro.S.
> 
> This can be used only when only one family is compiled in. Doing
> otherwise should be catched with an error during comppilation.
> 

Ok, thanks for the explanations.

	Arnd
