From: sean.wang@mediatek.com (Sean Wang)
Date: Wed, 2 Aug 2017 15:20:59 +0800
Subject: [PATCH 1/2] arm: dts: mt7623: fix mmc interrupt assignment
In-Reply-To: <20170801134009.14349-1-matthias.bgg@gmail.com>
References: <20170801134009.14349-1-matthias.bgg@gmail.com>
Message-ID: <1501658459.29348.1.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-08-01 at 15:40 +0200, Matthias Brugger wrote:
> The mmc1 interrupt should be connected to GIC_SPI 40,
> this patch fixes this.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  arch/arm/boot/dts/mt7623.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index 4ae0ab07e053..2a877ed8ff23 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -648,7 +648,7 @@
>  		compatible = "mediatek,mt7623-mmc",
>  			     "mediatek,mt8135-mmc";
>  		reg = <0 0x11240000 0 0x1000>;
> -		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_LOW>;
>  		clocks = <&pericfg CLK_PERI_MSDC30_1>,
>  			 <&topckgen CLK_TOP_MSDC30_1_SEL>;
>  		clock-names = "source", "hclk";


Hi, Matthias

many thanks!

Acked-by: Sean Wang <sean.wang@mediatek.com>

	Sean
