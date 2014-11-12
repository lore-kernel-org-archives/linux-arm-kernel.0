From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Nov 2014 18:42:41 +0800
Subject: [PATCH] ARM: imx: temporarily remove CONFIG_SOC_FSL from LS1021A
In-Reply-To: <1727581.y25NQPsRIm@wuerfel>
References: <1414746073-12394-1-git-send-email-jingchang.lu@freescale.com>
 <1414746073-12394-6-git-send-email-jingchang.lu@freescale.com>
 <1727581.y25NQPsRIm@wuerfel>
Message-ID: <20141112104239.GJ2704@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 05:03:25PM +0100, Arnd Bergmann wrote:
> The newly introduced LS1021A SoC selects CONFIG_SOC_FSL, which
> is originally symbol used for the PowerPC based platforms
> and guards lots of code that does not build on ARM.
> 
> This breaks allmodconfig, so let's remove it for now, until
> either all those drivers are fixed or they use a dependency
> on IMX instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> ---
> On Friday 31 October 2014 17:01:12 Jingchang Lu wrote:
> > From: Jingchang Lu <b35083@freescale.com>
> > 
> > The LS1021A SoC is a dual-core Cortex-A7 based processor,
> > this adds the initial support for it.
> > 
> > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> 
> >  
> > +config FSL_SOC
> > +       bool
> > +
> > +config SOC_LS1021A
> > +       bool "Freescale LS1021A support"
> > +       select ARM_GIC
> > +       select HAVE_ARM_ARCH_TIMER
> > +       select FSL_SOC
> >
> 
> 
> This broke allmodconfig builds in linux-next, please apply this
> partial revert for the moment.

I noticed the issue from 0-DAY testing and was trying to drop the patch.
Jingchang said someone is trying to fixing the issues from driver code.
But it seems to take some time.  So I agree with this partial reverting.

Patch applied.  Thanks Arnd.

Shawn

> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index ef549ef1cd6d..e8627e04e1e6 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -658,14 +658,10 @@ choice
>  
>  endchoice
>  
> -config FSL_SOC
> -	bool
> -
>  config SOC_LS1021A
>  	bool "Freescale LS1021A support"
>  	select ARM_GIC
>  	select HAVE_ARM_ARCH_TIMER
> -	select FSL_SOC
>  	select PCI_DOMAINS if PCI
>  	select ZONE_DMA if ARM_LPAE
>  
> 
