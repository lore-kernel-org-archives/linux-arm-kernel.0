From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 Sep 2011 21:34:33 +0800
Subject: [PATCH v3 4/6] arm/imx6q: add smp and cpu hotplug support
In-Reply-To: <20110926110634.GR31404@pengutronix.de>
References: <1317021651-17359-1-git-send-email-shawn.guo@linaro.org>
	<1317021651-17359-5-git-send-email-shawn.guo@linaro.org>
	<20110926110634.GR31404@pengutronix.de>
Message-ID: <20110926133432.GB17577@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 01:06:34PM +0200, Sascha Hauer wrote:
> On Mon, Sep 26, 2011 at 03:20:49PM +0800, Shawn Guo wrote:
> > It adds smp and cpu hotplug support for imx6q.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mach-imx/Kconfig               |    1 +
> >  arch/arm/mach-imx/Makefile              |    4 ++
> >  arch/arm/mach-imx/head-v7.S             |   71 ++++++++++++++++++++++++++
> >  arch/arm/mach-imx/hotplug.c             |   44 ++++++++++++++++
> >  arch/arm/mach-imx/localtimer.c          |   35 +++++++++++++
> >  arch/arm/mach-imx/platsmp.c             |   85 +++++++++++++++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/common.h |    5 ++
> >  7 files changed, 245 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-imx/head-v7.S
> >  create mode 100644 arch/arm/mach-imx/hotplug.c
> >  create mode 100644 arch/arm/mach-imx/localtimer.c
> >  create mode 100644 arch/arm/mach-imx/platsmp.c
> > 
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index af73b3e..6ec758d 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -623,6 +623,7 @@ config SOC_IMX6Q
> >  	bool "i.MX6 Quad support"
> >  	select ARM_GIC
> >  	select CPU_V7
> > +	select HAVE_ARM_SCU
> >  	select HAVE_IMX_GPC
> >  	select HAVE_IMX_MMDC
> >  	select HAVE_IMX_SRC
> > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > index 8c21fda..d46b2e7 100644
> > --- a/arch/arm/mach-imx/Makefile
> > +++ b/arch/arm/mach-imx/Makefile
> > @@ -66,4 +66,8 @@ obj-$(CONFIG_DEBUG_LL) += lluart.o
> >  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
> >  obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
> >  obj-$(CONFIG_HAVE_IMX_SRC) += src.o
> > +obj-$(CONFIG_CPU_V7) += head-v7.o
> 
> Can we have a
> 
> AFLAGS_head-v7.o :=-Wa,-march=armv7-a
> 
> here?
> 
> Then you only have to adjust some Kconfig variables and can compile
> i.MX3 and i.MX6 together. I just gave it a test and it works on i.MX3, I
> don't have a i.MX6 platform to test on though.
> 
> The following patch could be a starting point. I merged the imx-features
> branch into it so it probably won't apply cleanly on your series.
> 
I will try to test and fold it in my series tomorrow.

-- 
Regards,
Shawn
