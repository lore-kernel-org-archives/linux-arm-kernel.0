From: florian.vaussard@heig-vd.ch (Florian Vaussard)
Date: Fri, 27 Jan 2017 11:29:53 +0100
Subject: [PATCH v4 10/13] arm64: allwinner: a64: Increase the MMC max
 frequency
In-Reply-To: <dee0dc8e1d98698231738b10fbe79cdf6d5e4c36.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
 <dee0dc8e1d98698231738b10fbe79cdf6d5e4c36.1485421557.git-series.maxime.ripard@free-electrons.com>
Message-ID: <6c6bf169-4b2e-6b55-54db-d21da73a8f6e@heig-vd.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 01/26/2017 10:06 AM, Maxime Ripard wrote:
> The eMMC controller seem to have a maximum frequency of 200MHz, while the
> regular MMC controllers are capped at 150MHz.
> 
> Since older SoCs cannot go that high, we cannot change the default maximum
> frequency, but fortunately for us we have a property for that in the DT.
> 
> This also has the side effect of allowing to use the MMC HS200 and SD
> SDR104 modes for the boards that support it (with either 1.2v or 1.8v IOs).
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> arm64: allwinner: a64: Limit MMC0 and MMC1 rates to 150MHz
> 
> Trying to set the bus to 200MHz on MMC1 when doing SDIO is failing.
> Allwinner sets the maximum for this bus to 150MHz, so enforce that limit.
> 
> This hasn't been tested with MMC0, but the documented limit is the same,
> and I expect the behaviour to be the same.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I suspect that you are trying to increase your number of Signed-off-by tags by
using unfair means :) Otherwise the squashed commit message is probably worth
some cleaning.

Best,
Florian

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 +++
>  1 file changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 7b79c319ad3c..cb3e0cf2191a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -130,6 +130,7 @@
>  			resets = <&ccu RST_BUS_MMC0>;
>  			reset-names = "ahb";
>  			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +			max-frequency = <150000000>;
>  			status = "disabled";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -143,6 +144,7 @@
>  			resets = <&ccu RST_BUS_MMC1>;
>  			reset-names = "ahb";
>  			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +			max-frequency = <150000000>;
>  			status = "disabled";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -156,6 +158,7 @@
>  			resets = <&ccu RST_BUS_MMC2>;
>  			reset-names = "ahb";
>  			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +			max-frequency = <200000000>;
>  			status = "disabled";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> 
