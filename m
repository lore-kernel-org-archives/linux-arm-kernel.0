From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 May 2013 08:35:53 -0700
Subject: [PATCH 4/5] ARM: dts: OMAP3: fix incorrect notation for
 musb-hdrc interrupt
In-Reply-To: <1369232864-14460-5-git-send-email-florian.vaussard@epfl.ch>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
 <1369232864-14460-5-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20130522153552.GA10378@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [130522 07:33]:
> On OMAP3, the INTC interrupt controller has only 1 cell.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>

Thanks a similar fix is already queued up and on it's way to mainline
tree.

Regards,

Tony

> ---
>  arch/arm/boot/dts/omap3.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 15049b8..0f3be20 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -518,7 +518,7 @@
>  		usb_otg_hs: usb_otg_hs at 480ab000 {
>  			compatible = "ti,omap3-musb";
>  			reg = <0x480ab000 0x1000>;
> -			interrupts = <0 92 0x4>, <0 93 0x4>;
> +			interrupts = <92>, <93>;
>  			interrupt-names = "mc", "dma";
>  			ti,hwmods = "usb_otg_hs";
>  			multipoint = <1>;
> -- 
> 1.7.5.4
> 
