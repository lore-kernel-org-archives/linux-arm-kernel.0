From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Mar 2013 14:36:39 +0800
Subject: [PATCH 2/2] ARM: imx: Disable imx-cpufreq when cpufreq-cpu0 used
In-Reply-To: <20130310225159.GS1906@pengutronix.de>
References: <1362934407-29030-1-git-send-email-mpa@pengutronix.de>
 <1362934407-29030-3-git-send-email-mpa@pengutronix.de>
 <20130310225159.GS1906@pengutronix.de>
Message-ID: <20130311063636.GA25910@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 10, 2013 at 11:51:59PM +0100, Sascha Hauer wrote:
> On Sun, Mar 10, 2013 at 05:53:27PM +0100, Markus Pargmann wrote:
> > cpufreq-cpu0 has DT support. So if imx27 or imx51 is booted with DT
> > support, it should not use the old imx-cpufreq driver. Instead the
> > operating-points should be defined in the appropriate DT files.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  arch/arm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 5b71469..1247fe5 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -2156,6 +2156,7 @@ source "drivers/cpufreq/Kconfig"
> >  config CPU_FREQ_IMX
> >  	tristate "CPUfreq driver for i.MX CPUs"
> >  	depends on ARCH_MXC && CPU_FREQ
> > +	depends on (!GENERIC_CPUFREQ_CPU0 || (!MACH_IMX51_DT && !MACH_IMX27_DT))
> 
> Does this driver work with multiplatform anyway? I mean it registers
> a cpufreq driver without knowing that the kernel even runs on i.MX.
> Maybe removing it is the better option?
> 
+1 on killing imx cpufreq driver.

Shawn
