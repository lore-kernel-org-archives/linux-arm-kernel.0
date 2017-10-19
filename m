From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 19 Oct 2017 18:49:07 +0200
Subject: [PATCH v3 04/10] arm: dts: mediatek: update audio node for mt2701
 and mt7623
In-Reply-To: <13ee41c37cbfd0de335b6fbbf061715184944cb8.1506908511.git.ryder.lee@mediatek.com>
References: <cover.1506908511.git.ryder.lee@mediatek.com>
 <13ee41c37cbfd0de335b6fbbf061715184944cb8.1506908511.git.ryder.lee@mediatek.com>
Message-ID: <0f61ad91-2d9d-f7a5-6bc7-a543278068ba@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/02/2017 03:54 AM, Ryder Lee wrote:
> This patch adds interrupt-names property in audio node so that
> binding can be agnostic of the IRQ order.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  arch/arm/boot/dts/mt2701.dtsi | 4 +++-
>  arch/arm/boot/dts/mt7623.dtsi | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)


Pushed to v4.14-next/dts32

Thanks!

> 
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 8c9fbe5..ecd388a 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -445,7 +445,9 @@
>  		compatible = "mediatek,mt2701-audio";
>  		reg = <0 0x11220000 0 0x2000>,
>  		      <0 0x112a0000 0 0x20000>;
> -		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> +			      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names	= "afe", "asys";
>  		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
>  
>  		clocks = <&infracfg CLK_INFRA_AUDIO>,
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index ec8a074..381843e 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -544,7 +544,9 @@
>  			     "mediatek,mt2701-audio";
>  		reg = <0 0x11220000 0 0x2000>,
>  		      <0 0x112a0000 0 0x20000>;
> -		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> +			      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names	= "afe", "asys";
>  		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
>  
>  		clocks = <&infracfg CLK_INFRA_AUDIO>,
> 
