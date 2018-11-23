From: ccaione@baylibre.com (Carlo Caione)
Date: Fri, 23 Nov 2018 14:43:03 +0000
Subject: [PATCH] arm64: dts: meson-axg: Enable watchdog on Meson AXG SoCs
In-Reply-To: <20181123140552.5420-1-ccaione@baylibre.com>
References: <20181123140552.5420-1-ccaione@baylibre.com>
Message-ID: <5f648387-18db-fd36-a79a-2d6146e4e40c@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/2018 14:05, Carlo Caione wrote:
> Add the watchdog node also on the AXG platforms.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index df017dbd2e57..e8cd580665bc 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1422,6 +1422,12 @@
>   				status = "disabled";
>   			};
>   
> +			watchdog at f0d0 {
> +				compatible = "amlogic,meson-axg-wdt", "amlogic,meson-gxbb-wdt";

The axg compatible is actually not needed. Preparing a v2.

--
Carlo Caione
