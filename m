From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 15 May 2014 07:57:35 -0700
Subject: [PATCH] ARM: zynq: dt: Add a fixed regulator for CPU voltage
In-Reply-To: <1399064852-19569-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1399064852-19569-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <e9675d40-2fd9-4fed-a020-5b465ea1842d@BN1BFFO11FD047.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping? Any comments?

	Thanks,
	S?ren

On Fri, 2014-05-02 at 02:07PM -0700, Soren Brinkmann wrote:
> To silence the warning
> 	cpufreq_cpu0: failed to get cpu0 regulator: -19
> from the cpufreq driver regarding a missing regulator,
> add a fixed regulator to the DT.
> Zynq does not support voltage scaling and the CPU rail should always be
> supplied with 1 V, hence it is added in the SOC-level dtsi.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> 
>  arch/arm/boot/dts/zynq-7000.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index c1176abc34d9..64779f9d5c38 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -25,6 +25,7 @@
>  			reg = <0>;
>  			clocks = <&clkc 3>;
>  			clock-latency = <1000>;
> +			cpu0-supply = <&regulator_vccpint>;
>  			operating-points = <
>  				/* kHz    uV */
>  				666667  1000000
> @@ -48,6 +49,15 @@
>  		reg = < 0xf8891000 0x1000 0xf8893000 0x1000 >;
>  	};
>  
> +	regulator_vccpint: fixedregulator at 0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCCPINT";
> +		regulator-min-microvolt = <1000000>;
> +		regulator-max-microvolt = <1000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>  	amba {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> -- 
> 1.9.2.1.g06c4abd
> 
> 
