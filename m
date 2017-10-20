From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 20 Oct 2017 13:17:20 +0200
Subject: [PATCH 1/3] arm: dts: mt7623: update crypto node
In-Reply-To: <4cabb9ad6f59b42cc10ba25a9eb0ce68f77d0a43.1508492662.git.ryder.lee@mediatek.com>
References: <4cabb9ad6f59b42cc10ba25a9eb0ce68f77d0a43.1508492662.git.ryder.lee@mediatek.com>
Message-ID: <f7195796-38c9-746c-55d1-c1056c12826f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/20/2017 11:46 AM, Ryder Lee wrote:
> This patch updates compatible string and clocks for the crypto node.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---

All three pushed to v4.14-next/dts32

Thanks!

>  arch/arm/boot/dts/mt7623.dtsi | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index d0483f7..6c2c8c8 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -892,16 +892,15 @@
>  	};
>  
>  	crypto: crypto at 1b240000 {
> -		compatible = "mediatek,mt7623-crypto";
> +		compatible = "mediatek,eip97-crypto";
>  		reg = <0 0x1b240000 0 0x20000>;
>  		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>;
> -		clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
> -			 <&ethsys CLK_ETHSYS_CRYPTO>;
> -		clock-names = "ethif","cryp";
> +		clocks = <&ethsys CLK_ETHSYS_CRYPTO>;
> +		clock-names = "cryp";
>  		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
>  		status = "disabled";
>  	};
> 
