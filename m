From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 2 Feb 2012 17:42:52 +0800
Subject: [PATCH v2 7/9] ARM: mxc: move audmux-v2 to sound/soc/imx
In-Reply-To: <20120202090248.GC9773@S2101-09.ap.freescale.net>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-8-git-send-email-richard.zhao@linaro.org>
 <20120202090248.GC9773@S2101-09.ap.freescale.net>
Message-ID: <20120202094252.GC32403@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 05:02:50PM +0800, Shawn Guo wrote:
> On Thu, Feb 02, 2012 at 10:12:06AM +0800, Richard Zhao wrote:
> > It's for clean up code under arch/arm.
> > 
> > audmux.h is shared with audmux-v1, leave it under mach/.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  arch/arm/plat-mxc/Kconfig                        |    3 ---
> >  arch/arm/plat-mxc/Makefile                       |    1 -
> >  sound/soc/imx/Kconfig                            |    4 ++++
> >  sound/soc/imx/Makefile                           |    2 ++
> >  {arch/arm/plat-mxc => sound/soc/imx}/audmux-v2.c |    0
> >  5 files changed, 6 insertions(+), 4 deletions(-)
> >  rename {arch/arm/plat-mxc => sound/soc/imx}/audmux-v2.c (100%)
> > 
> > diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> > index dcebb12..9e47d9c 100644
> > --- a/arch/arm/plat-mxc/Kconfig
> > +++ b/arch/arm/plat-mxc/Kconfig
> > @@ -91,9 +91,6 @@ config ARCH_MXC_IOMUX_V3
> >  config ARCH_MXC_AUDMUX_V1
> >  	bool
> >  
> > -config ARCH_MXC_AUDMUX_V2
> > -	bool
> > -
> 
> There are 4 more occurrences of the symbol to be removed together.
> 
> arch/arm/mach-imx/Kconfig:58:   select ARCH_MXC_AUDMUX_V2
> arch/arm/mach-imx/Kconfig:75:   select ARCH_MXC_AUDMUX_V2
> arch/arm/mach-imx/Kconfig:83:   select ARCH_MXC_AUDMUX_V2
> arch/arm/mach-imx/Kconfig:92:   select ARCH_MXC_AUDMUX_V2
right.

Thanks
Richard
> 
> Regards,
> Shawn
