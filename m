From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Sep 2014 17:58:09 -0700
Subject: [PATCH 1/6] ARM: dts: OMAP3+: Add PRM interrupt
In-Reply-To: <1408716235-26164-2-git-send-email-nm@ti.com>
References: <1408716235-26164-1-git-send-email-nm@ti.com>
 <1408716235-26164-2-git-send-email-nm@ti.com>
Message-ID: <20140909005808.GG10785@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140822 07:08]:
> Provide OMAP3, 4 and OMAP5 with interrupt number for PRM
> 
> And for DRA7, provide crossbar number for prm interrupt.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

I've picked this patch only into omap-for-v3.18/soc as
this is needed for Felipe's intc related changes to work
properly with the wake-up interrupts for DT based booting
for off-idle.

So please don't include this patch into your pull request
for the other dts changes you have.

Regards,

Tony

> ---
>  arch/arm/boot/dts/dra7.dtsi  |    1 +
>  arch/arm/boot/dts/omap3.dtsi |    1 +
>  arch/arm/boot/dts/omap4.dtsi |    1 +
>  arch/arm/boot/dts/omap5.dtsi |    1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 97f603c..7a3e011 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -89,6 +89,7 @@
>  		prm: prm at 4ae06000 {
>  			compatible = "ti,dra7-prm";
>  			reg = <0x4ae06000 0x3000>;
> +			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>  
>  			prm_clocks: clocks {
>  				#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 575a49b..3136ed1 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -97,6 +97,7 @@
>  		prm: prm at 48306000 {
>  			compatible = "ti,omap3-prm";
>  			reg = <0x48306000 0x4000>;
> +			interrupts = <11>;
>  
>  			prm_clocks: clocks {
>  				#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 69408b5..7375d44 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -129,6 +129,7 @@
>  		prm: prm at 4a306000 {
>  			compatible = "ti,omap4-prm";
>  			reg = <0x4a306000 0x3000>;
> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>  
>  			prm_clocks: clocks {
>  				#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index fc8df17..df0a09b 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -131,6 +131,7 @@
>  		prm: prm at 4ae06000 {
>  			compatible = "ti,omap5-prm";
>  			reg = <0x4ae06000 0x3000>;
> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>  
>  			prm_clocks: clocks {
>  				#address-cells = <1>;
> -- 
> 1.7.9.5
> 
