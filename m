From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 9 Nov 2018 10:39:25 +0100
Subject: [PATCH 4/4] arm64: dts: meson-axg: enable SCPI
In-Reply-To: <20181108135352.8459-5-jbrunet@baylibre.com>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
 <20181108135352.8459-5-jbrunet@baylibre.com>
Message-ID: <e7b4b5a6-717a-fb58-74a1-24d713193541@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2018 14:53, Jerome Brunet wrote:
> Enable SCPI on the axg platform, with cpu clock and hwmon
> (core temperature) support
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index b8893675e39c..5f512c91471e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -79,6 +79,7 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&l2>;
> +			clocks = <&scpi_dvfs 0>;
>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -87,6 +88,7 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
>  			next-level-cache = <&l2>;
> +			clocks = <&scpi_dvfs 0>;
>  		};
>  
>  		cpu2: cpu at 2 {
> @@ -95,6 +97,7 @@
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
>  			next-level-cache = <&l2>;
> +			clocks = <&scpi_dvfs 0>;
>  		};
>  
>  		cpu3: cpu at 3 {
> @@ -103,6 +106,7 @@
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
>  			next-level-cache = <&l2>;
> +			clocks = <&scpi_dvfs 0>;
>  		};
>  
>  		l2: l2-cache0 {
> @@ -137,6 +141,28 @@
>  		};
>  	};
>  
> +	scpi {
> +		compatible = "arm,scpi-pre-1.0";
> +		mboxes = <&mailbox 1 &mailbox 2>;
> +		shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
> +
> +		scpi_clocks: clocks {
> +			compatible = "arm,scpi-clocks";
> +
> +			scpi_dvfs: clock-controller {
> +				compatible = "arm,scpi-dvfs-clocks";
> +				#clock-cells = <1>;
> +				clock-indices = <0>;
> +				clock-output-names = "vcpu";
> +			};
> +		};
> +
> +		scpi_sensors: sensors {
> +			compatible = "amlogic,meson-gxbb-scpi-sensors";
> +			#thermal-sensor-cells = <1>;
> +		};
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
