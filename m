From: liviu.dudau@arm.com (Liviu Dudau)
Date: Wed, 8 Jun 2016 17:05:33 +0100
Subject: [PATCH 3/3] arm64: dts: juno: add SCPI power domains for device
 power management
In-Reply-To: <1465228765-14038-4-git-send-email-sudeep.holla@arm.com>
References: <1465228765-14038-1-git-send-email-sudeep.holla@arm.com>
 <1465228765-14038-4-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160608160532.GR1165@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 04:59:25PM +0100, Sudeep Holla wrote:
> This patch adds power domain information to coresight devices using
> SCPI power domains.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index 49fa55cdc977..ef054094d5a8 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -75,6 +75,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -105,6 +106,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		port {
>  			tpiu_in_port: endpoint {
>  				slave-mode;
> @@ -120,6 +122,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -157,6 +160,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		port {
>  			etr_in_port: endpoint {
>  				slave-mode;
> @@ -208,6 +212,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -244,6 +249,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -293,6 +299,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		port {
>  			cluster0_etm0_out_port: endpoint {
>  				remote-endpoint = <&cluster0_funnel_in_port0>;
> @@ -306,6 +313,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		port {
>  			cluster0_etm1_out_port: endpoint {
>  				remote-endpoint = <&cluster0_funnel_in_port1>;
> @@ -319,6 +327,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		port {
>  			cluster1_etm0_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port0>;
> @@ -332,6 +341,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		port {
>  			cluster1_etm1_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port1>;
> @@ -345,6 +355,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		port {
>  			cluster1_etm2_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port2>;
> @@ -358,6 +369,7 @@
> 
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  		port {
>  			cluster1_etm3_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port3>;
> @@ -428,6 +440,12 @@
>  			};
>  		};
> 
> +		scpi_devpd: scpi-power-domains {
> +			compatible = "arm,scpi-power-domains";
> +			num-domains = <2>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		scpi_sensors0: sensors {
>  			compatible = "arm,scpi-sensors";
>  			#thermal-sensor-cells = <1>;
> --
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
