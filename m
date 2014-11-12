From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Nov 2014 07:28:54 -0800
Subject: [PATCH] ARM: dts: DRA7: wdt: Fix compatible property for
 watchdog node
In-Reply-To: <1415769855-32565-1-git-send-email-lokeshvutla@ti.com>
References: <1415769855-32565-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <20141112152853.GH26481@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [141111 21:27]:
> OMAP wdt driver supports only ti,omap3-wdt compatible. In DRA7 dt
> wdt compatible property is defined as ti,omap4-wdt by mistake instead of
> ti,omap3-wdt. Correcting the typo.
> 
> Fixes: 6e58b8f1daaf1a ("ARM: dts: DRA7: Add the dts files for dra7 SoC and dra7-evm board")
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks applying into omap-for-v3.19/fixes-not-urgent as this is
a feature that clearly never worked on dra7xx with mainline kernel.

Regards,

Tony

> ---
>  arch/arm/boot/dts/dra7.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 9cc9843..666e796 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -653,7 +653,7 @@
>  		};
>  
>  		wdt2: wdt at 4ae14000 {
> -			compatible = "ti,omap4-wdt";
> +			compatible = "ti,omap3-wdt";
>  			reg = <0x4ae14000 0x80>;
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>  			ti,hwmods = "wd_timer2";
> -- 
> 1.9.1
> 
