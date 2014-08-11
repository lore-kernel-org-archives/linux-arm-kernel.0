From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 11 Aug 2014 09:50:12 +0200
Subject: [PATCH 2/4] ARM: rockchip: enable the AMBA bus
In-Reply-To: <53E839F3.7040208@rock-chips.com>
References: <1406661128-7614-1-git-send-email-heiko@sntech.de>
 <1406661128-7614-3-git-send-email-heiko@sntech.de>
 <53E839F3.7040208@rock-chips.com>
Message-ID: <16000182.xrvOKsDCOX@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 11. August 2014, 11:35:15 schrieb Kever Yang:
> Heiko:
> 
> On 07/30/2014 03:12 AM, Heiko Stuebner wrote:
> > This is needed to access the pl330 dma controllers on Rockchip SoCs.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >   arch/arm/mach-rockchip/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-rockchip/Kconfig
> > b/arch/arm/mach-rockchip/Kconfig index d168669..ac5803c 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -4,6 +4,7 @@ config ARCH_ROCKCHIP
> > 
> >   	select PINCTRL_ROCKCHIP
> >   	select ARCH_HAS_RESET_CONTROLLER
> >   	select ARCH_REQUIRE_GPIOLIB
> > 
> > +	select ARM_AMBA
> 
> These two config is also needed by pl330 dma driver. Can we add it here?
>      DMADEVICES
>      PL330_DMA

I guess this should simply be done via the regular Kconfig (and _defconfig) and 
not be automatically selected. There may always be use-cases where people do 
not want to use dma operations and drivers needing them.


Heiko
