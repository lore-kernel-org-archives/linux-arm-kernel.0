From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 11 Nov 2015 13:39:00 -0800
Subject: [PATCH v6 3/3] arm64: dts: mt8173: Add nor flash node
In-Reply-To: <1446824889-16144-4-git-send-email-bayi.cheng@mediatek.com>
References: <1446824889-16144-1-git-send-email-bayi.cheng@mediatek.com>
 <1446824889-16144-4-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <20151111213900.GK12143@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 11:48:09PM +0800, Bayi Cheng wrote:
> Add Mediatek nor flash node
> 
> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>

Acked-by: Brian Norris <computersforpeace@gmail.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index d18ee42..f5f08eb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -365,6 +365,22 @@
>  			status = "disabled";
>  		};
>  
> +		nor_flash: spi at 1100d000 {
> +			compatible = "mediatek,mt8173-nor";
> +			reg = <0 0x1100d000 0 0xe0>;
> +			clocks = <&pericfg CLK_PERI_SPI>,
> +				 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> +			clock-names = "spi", "sf";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			flash at 0 {
> +				compatible = "jedec,spi-nor";
> +				reg = <0>;
> +			};
> +		};
> +
>  		i2c3: i2c3 at 11010000 {
>  			compatible = "mediatek,mt8173-i2c";
>  			reg = <0 0x11010000 0 0x70>,
> -- 
> 1.8.1.1.dirty
> 
