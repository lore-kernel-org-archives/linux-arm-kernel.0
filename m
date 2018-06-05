From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 05 Jun 2018 10:05:04 +0200
Subject: [PATCH] ARM64: dts: meson-axg: fix register ranges for SD/eMMC
In-Reply-To: <20180604222706.36167-1-khilman@baylibre.com>
References: <20180604222706.36167-1-khilman@baylibre.com>
Message-ID: <1528185904.10642.52.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-06-04 at 15:27 -0700, Kevin Hilman wrote:
> Based on updated information from Amlogic, correct the register
> range for the SD/eMMC blocks to the right size.
> 
> Reported-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Shouldn't we make the same the change on the gx family ?

> ---
> Yixun, please test and confirm this still works on AXG boards.
> 
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index fee87737a201..67d7115e4eff 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -132,7 +132,7 @@
>  
>  			sd_emmc_b: sd at 5000 {
>  				compatible = "amlogic,meson-axg-mmc";
> -				reg = <0x0 0x5000 0x0 0x2000>;
> +				reg = <0x0 0x5000 0x0 0x800>;
>  				interrupts = <GIC_SPI 217 IRQ_TYPE_EDGE_RISING>;
>  				status = "disabled";
>  				clocks = <&clkc CLKID_SD_EMMC_B>,
> @@ -144,7 +144,7 @@
>  
>  			sd_emmc_c: mmc at 7000 {
>  				compatible = "amlogic,meson-axg-mmc";
> -				reg = <0x0 0x7000 0x0 0x2000>;
> +				reg = <0x0 0x7000 0x0 0x800>;
>  				interrupts = <GIC_SPI 218 IRQ_TYPE_EDGE_RISING>;
>  				status = "disabled";
>  				clocks = <&clkc CLKID_SD_EMMC_C>,
