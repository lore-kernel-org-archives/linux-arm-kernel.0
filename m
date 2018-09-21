From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 21 Sep 2018 15:06:58 +0100
Subject: [PATCH v2 06/11] arm: dts: hip04: Update coresight bindings for
 hardware ports
In-Reply-To: <20180912135352.19722-7-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-7-suzuki.poulose@arm.com>
Message-ID: <5BA4FB02.1000607@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 2018/9/12 14:53, Suzuki K Poulose wrote:
> Switch to the new the hardware port bindings.
> 
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  arch/arm/boot/dts/hip04.dtsi | 346 ++++++++++++++++++-----------------
>  1 file changed, 176 insertions(+), 170 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
> index 44044f275115..0f917b272ff3 100644
> --- a/arch/arm/boot/dts/hip04.dtsi
> +++ b/arch/arm/boot/dts/hip04.dtsi
> @@ -277,10 +277,11 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		port {
> -			etb0_in_port: endpoint at 0 {
> -				slave-mode;
> -				remote-endpoint = <&replicator0_out_port0>;
> +		in-ports {
> +			port {
> +				etb0_in_port: endpoint at 0 {
> +					remote-endpoint = <&replicator0_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -291,10 +292,11 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		port {
> -			etb1_in_port: endpoint at 0 {
> -				slave-mode;
> -				remote-endpoint = <&replicator1_out_port0>;
> +		in-ports {
> +			port {
> +				etb1_in_port: endpoint at 0 {
> +					remote-endpoint = <&replicator1_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -305,10 +307,11 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		port {
> -			etb2_in_port: endpoint at 0 {
> -				slave-mode;
> -				remote-endpoint = <&replicator2_out_port0>;
> +		in-ports {
> +			port {
> +				etb2_in_port: endpoint at 0 {
> +					remote-endpoint = <&replicator2_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -319,10 +322,11 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		port {
> -			etb3_in_port: endpoint at 0 {
> -				slave-mode;
> -				remote-endpoint = <&replicator3_out_port0>;
> +		in-ports {
> +			port {
> +				etb3_in_port: endpoint at 0 {
> +					remote-endpoint = <&replicator3_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -333,10 +337,11 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		port {
> -			tpiu_in_port: endpoint at 0 {
> -				slave-mode;
> -				remote-endpoint = <&funnel4_out_port0>;
> +		in-ports {
> +			port {
> +				tpiu_in_port: endpoint at 0 {
> +					remote-endpoint = <&funnel4_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -347,7 +352,7 @@
>  		 */
>  		compatible = "arm,coresight-replicator";
>  
> -		ports {
> +		out-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> @@ -365,12 +370,11 @@
>  					remote-endpoint = <&funnel4_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* replicator input port */
> -			port at 2 {
> -				reg = <0>;
> +		in-ports {
> +			port {
>  				replicator0_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&funnel0_out_port0>;
>  				};
>  			};
> @@ -383,7 +387,7 @@
>  		 */
>  		compatible = "arm,coresight-replicator";
>  
> -		ports {
> +		out-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> @@ -401,12 +405,11 @@
>  					remote-endpoint = <&funnel4_in_port1>;
>  				};
>  			};
> +		};
>  
> -			/* replicator input port */
> -			port at 2 {
> -				reg = <0>;
> +		in-ports {
> +			port {
>  				replicator1_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&funnel1_out_port0>;
>  				};
>  			};
> @@ -419,11 +422,10 @@
>  		 */
>  		compatible = "arm,coresight-replicator";
>  
> -		ports {
> +		out-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			/* replicator output ports */
>  			port at 0 {
>  				reg = <0>;
>  				replicator2_out_port0: endpoint {
> @@ -437,12 +439,11 @@
>  					remote-endpoint = <&funnel4_in_port2>;
>  				};
>  			};
> +		};
>  
> -			/* replicator input port */
> -			port at 2 {
> -				reg = <0>;
> +		in-ports {
> +			port {
>  				replicator2_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&funnel2_out_port0>;
>  				};
>  			};
> @@ -455,11 +456,10 @@
>  		 */
>  		compatible = "arm,coresight-replicator";
>  
> -		ports {
> +		out-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			/* replicator output ports */
>  			port at 0 {
>  				reg = <0>;
>  				replicator3_out_port0: endpoint {
> @@ -473,12 +473,11 @@
>  					remote-endpoint = <&funnel4_in_port3>;
>  				};
>  			};
> +		};
>  
> -			/* replicator input port */
> -			port at 2 {
> -				reg = <0>;
> +		in-ports {
> +			port {
>  				replicator3_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&funnel3_out_port0>;
>  				};
>  			};
> @@ -491,48 +490,43 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* funnel output port */
> -			port at 0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				funnel0_out_port0: endpoint {
>  					remote-endpoint =
>  						<&replicator0_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* funnel input ports */
> -			port at 1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
>  				reg = <0>;
>  				funnel0_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm0_out_port>;
>  				};
>  			};
>  
> -			port at 2 {
> +			port at 1 {
>  				reg = <1>;
>  				funnel0_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm1_out_port>;
>  				};
>  			};
>  
> -			port at 3 {
> +			port at 2 {
>  				reg = <2>;
>  				funnel0_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm2_out_port>;
>  				};
>  			};
>  
> -			port at 4 {
> +			port at 3 {
>  				reg = <3>;
>  				funnel0_in_port3: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm3_out_port>;
>  				};
>  			};
> @@ -545,48 +539,43 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* funnel output port */
> -			port at 0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				funnel1_out_port0: endpoint {
>  					remote-endpoint =
>  						<&replicator1_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* funnel input ports */
> -			port at 1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
>  				reg = <0>;
>  				funnel1_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm4_out_port>;
>  				};
>  			};
>  
> -			port at 2 {
> +			port at 1 {
>  				reg = <1>;
>  				funnel1_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm5_out_port>;
>  				};
>  			};
>  
> -			port at 3 {
> +			port at 2 {
>  				reg = <2>;
>  				funnel1_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm6_out_port>;
>  				};
>  			};
>  
> -			port at 4 {
> +			port at 3 {
>  				reg = <3>;
>  				funnel1_in_port3: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm7_out_port>;
>  				};
>  			};
> @@ -599,48 +588,43 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* funnel output port */
> -			port at 0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				funnel2_out_port0: endpoint {
>  					remote-endpoint =
>  						<&replicator2_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* funnel input ports */
> -			port at 1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
>  				reg = <0>;
>  				funnel2_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm8_out_port>;
>  				};
>  			};
>  
> -			port at 2 {
> +			port at 1 {
>  				reg = <1>;
>  				funnel2_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm9_out_port>;
>  				};
>  			};
>  
> -			port at 3 {
> +			port at 2 {
>  				reg = <2>;
>  				funnel2_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm10_out_port>;
>  				};
>  			};
>  
> -			port at 4 {
> +			port at 3 {
>  				reg = <3>;
>  				funnel2_in_port3: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm11_out_port>;
>  				};
>  			};
> @@ -653,48 +637,43 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* funnel output port */
> -			port at 0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				funnel3_out_port0: endpoint {
>  					remote-endpoint =
>  						<&replicator3_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* funnel input ports */
> -			port at 1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
>  				reg = <0>;
>  				funnel3_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm12_out_port>;
>  				};
>  			};
>  
> -			port at 2 {
> +			port at 1 {
>  				reg = <1>;
>  				funnel3_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm13_out_port>;
>  				};
>  			};
>  
> -			port at 3 {
> +			port at 2 {
>  				reg = <2>;
>  				funnel3_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm14_out_port>;
>  				};
>  			};
>  
> -			port at 4 {
> +			port at 3 {
>  				reg = <3>;
>  				funnel3_in_port3: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm15_out_port>;
>  				};
>  			};
> @@ -707,50 +686,45 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* funnel output port */
> -			port at 0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				funnel4_out_port0: endpoint {
>  					remote-endpoint = <&tpiu_in_port>;
>  				};
>  			};
> +		};
>  
> -			/* funnel input ports */
> -			port at 1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
>  				reg = <0>;
>  				funnel4_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint =
>  						<&replicator0_out_port1>;
>  				};
>  			};
>  
> -			port at 2 {
> +			port at 1 {
>  				reg = <1>;
>  				funnel4_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint =
>  						<&replicator1_out_port1>;
>  				};
>  			};
>  
> -			port at 3 {
> +			port at 2 {
>  				reg = <2>;
>  				funnel4_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint =
>  						<&replicator2_out_port1>;
>  				};
>  			};
>  
> -			port at 4 {
> +			port at 3 {
>  				reg = <3>;
>  				funnel4_in_port3: endpoint {
> -					slave-mode;
>  					remote-endpoint =
>  						<&replicator3_out_port1>;
>  				};
> @@ -765,9 +739,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU0>;
> -		port {
> -			ptm0_out_port: endpoint {
> -				remote-endpoint = <&funnel0_in_port0>;
> +		out-ports {
> +			port {
> +				ptm0_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -779,9 +755,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU1>;
> -		port {
> -			ptm1_out_port: endpoint {
> -				remote-endpoint = <&funnel0_in_port1>;
> +		out-ports {
> +			port {
> +				ptm1_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -793,9 +771,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU2>;
> -		port {
> -			ptm2_out_port: endpoint {
> -				remote-endpoint = <&funnel0_in_port2>;
> +		out-ports {
> +			port {
> +				ptm2_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port2>;
> +				};
>  			};
>  		};
>  	};
> @@ -807,9 +787,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU3>;
> -		port {
> -			ptm3_out_port: endpoint {
> -				remote-endpoint = <&funnel0_in_port3>;
> +		out-ports {
> +			port {
> +				ptm3_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port3>;
> +				};
>  			};
>  		};
>  	};
> @@ -821,9 +803,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU4>;
> -		port {
> -			ptm4_out_port: endpoint {
> -				remote-endpoint = <&funnel1_in_port0>;
> +		out-ports {
> +			port {
> +				ptm4_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -835,9 +819,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU5>;
> -		port {
> -			ptm5_out_port: endpoint {
> -				remote-endpoint = <&funnel1_in_port1>;
> +		out-ports {
> +			port {
> +				ptm5_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -849,9 +835,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU6>;
> -		port {
> -			ptm6_out_port: endpoint {
> -				remote-endpoint = <&funnel1_in_port2>;
> +		out-ports {
> +			port {
> +				ptm6_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port2>;
> +				};
>  			};
>  		};
>  	};
> @@ -863,9 +851,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU7>;
> -		port {
> -			ptm7_out_port: endpoint {
> -				remote-endpoint = <&funnel1_in_port3>;
> +		out-ports {
> +			port {
> +				ptm7_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port3>;
> +				};
>  			};
>  		};
>  	};
> @@ -877,9 +867,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU8>;
> -		port {
> -			ptm8_out_port: endpoint {
> -				remote-endpoint = <&funnel2_in_port0>;
> +		out-ports {
> +			port {
> +				ptm8_out_port: endpoint {
> +					remote-endpoint = <&funnel2_in_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -890,9 +882,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU9>;
> -		port {
> -			ptm9_out_port: endpoint {
> -				remote-endpoint = <&funnel2_in_port1>;
> +		out-ports {
> +			port {
> +				ptm9_out_port: endpoint {
> +					remote-endpoint = <&funnel2_in_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -904,9 +898,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU10>;
> -		port {
> -			ptm10_out_port: endpoint {
> -				remote-endpoint = <&funnel2_in_port2>;
> +		out-ports {
> +			port {
> +				ptm10_out_port: endpoint {
> +					remote-endpoint = <&funnel2_in_port2>;
> +				};
>  			};
>  		};
>  	};
> @@ -918,9 +914,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU11>;
> -		port {
> -			ptm11_out_port: endpoint {
> -				remote-endpoint = <&funnel2_in_port3>;
> +		out-ports {
> +			port {
> +				ptm11_out_port: endpoint {
> +					remote-endpoint = <&funnel2_in_port3>;
> +				};
>  			};
>  		};
>  	};
> @@ -932,9 +930,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU12>;
> -		port {
> -			ptm12_out_port: endpoint {
> -				remote-endpoint = <&funnel3_in_port0>;
> +		out-ports {
> +			port {
> +				ptm12_out_port: endpoint {
> +					remote-endpoint = <&funnel3_in_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -946,9 +946,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU13>;
> -		port {
> -			ptm13_out_port: endpoint {
> -				remote-endpoint = <&funnel3_in_port1>;
> +		out-ports {
> +			port {
> +				ptm13_out_port: endpoint {
> +					remote-endpoint = <&funnel3_in_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -960,9 +962,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU14>;
> -		port {
> -			ptm14_out_port: endpoint {
> -				remote-endpoint = <&funnel3_in_port2>;
> +		out-ports {
> +			port {
> +				ptm14_out_port: endpoint {
> +					remote-endpoint = <&funnel3_in_port2>;
> +				};
>  			};
>  		};
>  	};
> @@ -974,9 +978,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU15>;
> -		port {
> -			ptm15_out_port: endpoint {
> -				remote-endpoint = <&funnel3_in_port3>;
> +		out-ports {
> +			port {
> +				ptm15_out_port: endpoint {
> +					remote-endpoint = <&funnel3_in_port3>;
> +				};
>  			};
>  		};
>  	};
> 
