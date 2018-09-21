From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 21 Sep 2018 15:06:34 +0100
Subject: [PATCH v2 03/11] arm64: dts: hi6220: Update coresight bindings
 for hardware ports
In-Reply-To: <20180912135352.19722-4-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-4-suzuki.poulose@arm.com>
Message-ID: <5BA4FAEA.3010502@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 2018/9/12 14:53, Suzuki K Poulose wrote:
> Switch to updated coresight bindings for hw ports.
> 
> Cc: xuwei5 at hisilicon.com
> Cc: lipengcheng8 at huawei.com
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  .../boot/dts/hisilicon/hi6220-coresight.dtsi  | 181 +++++++++---------
>  1 file changed, 86 insertions(+), 95 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> index 7afee5d5087b..68c52f1149be 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> @@ -20,22 +20,18 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port at 0 {
> -					reg = <0>;
> +			out-ports {
> +				port {
>  					soc_funnel_out: endpoint {
>  						remote-endpoint =
>  							<&etf_in>;
>  					};
>  				};
> +			};
>  
> -				port at 1 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>  					soc_funnel_in: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&acpu_funnel_out>;
>  					};
> @@ -49,21 +45,17 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port at 0 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>  					etf_in: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&soc_funnel_out>;
>  					};
>  				};
> +			};
>  
> -				port at 1 {
> -					reg = <0>;
> +			out-ports {
> +				port {
>  					etf_out: endpoint {
>  						remote-endpoint =
>  							<&replicator_in>;
> @@ -77,20 +69,20 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port at 0 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>  					replicator_in: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etf_out>;
>  					};
>  				};
> +			};
>  
> -				port at 1 {
> +			out-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port at 0 {
>  					reg = <0>;
>  					replicator_out0: endpoint {
>  						remote-endpoint =
> @@ -98,7 +90,7 @@
>  					};
>  				};
>  
> -				port at 2 {
> +				port at 1 {
>  					reg = <1>;
>  					replicator_out1: endpoint {
>  						remote-endpoint =
> @@ -114,14 +106,9 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port at 0 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>  					etr_in: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&replicator_out0>;
>  					};
> @@ -135,14 +122,9 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port at 0 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>  					tpiu_in: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&replicator_out1>;
>  					};
> @@ -156,85 +138,78 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port at 0 {
> -					reg = <0>;
> +			out-ports {
> +				port {
>  					acpu_funnel_out: endpoint {
>  						remote-endpoint =
>  							<&soc_funnel_in>;
>  					};
>  				};
> +			};
>  
> -				port at 1 {
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port at 0 {
>  					reg = <0>;
>  					acpu_funnel_in0: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm0_out>;
>  					};
>  				};
>  
> -				port at 2 {
> +				port at 1 {
>  					reg = <1>;
>  					acpu_funnel_in1: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm1_out>;
>  					};
>  				};
>  
> -				port at 3 {
> +				port at 2 {
>  					reg = <2>;
>  					acpu_funnel_in2: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm2_out>;
>  					};
>  				};
>  
> -				port at 4 {
> +				port at 3 {
>  					reg = <3>;
>  					acpu_funnel_in3: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm3_out>;
>  					};
>  				};
>  
> -				port at 5 {
> +				port at 4 {
>  					reg = <4>;
>  					acpu_funnel_in4: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm4_out>;
>  					};
>  				};
>  
> -				port at 6 {
> +				port at 5 {
>  					reg = <5>;
>  					acpu_funnel_in5: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm5_out>;
>  					};
>  				};
>  
> -				port at 7 {
> +				port at 6 {
>  					reg = <6>;
>  					acpu_funnel_in6: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm6_out>;
>  					};
>  				};
>  
> -				port at 8 {
> +				port at 7 {
>  					reg = <7>;
>  					acpu_funnel_in7: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm7_out>;
>  					};
> @@ -251,10 +226,12 @@
>  
>  			cpu = <&cpu0>;
>  
> -			port {
> -				etm0_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in0>;
> +			out-ports {
> +				port {
> +					etm0_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in0>;
> +					};
>  				};
>  			};
>  		};
> @@ -268,10 +245,12 @@
>  
>  			cpu = <&cpu1>;
>  
> -			port {
> -				etm1_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in1>;
> +			out-ports {
> +				port {
> +					etm1_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in1>;
> +					};
>  				};
>  			};
>  		};
> @@ -285,10 +264,12 @@
>  
>  			cpu = <&cpu2>;
>  
> -			port {
> -				etm2_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in2>;
> +			out-ports {
> +				port {
> +					etm2_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in2>;
> +					};
>  				};
>  			};
>  		};
> @@ -302,10 +283,12 @@
>  
>  			cpu = <&cpu3>;
>  
> -			port {
> -				etm3_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in3>;
> +			out-ports {
> +				port {
> +					etm3_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in3>;
> +					};
>  				};
>  			};
>  		};
> @@ -319,10 +302,12 @@
>  
>  			cpu = <&cpu4>;
>  
> -			port {
> -				etm4_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in4>;
> +			out-ports {
> +				port {
> +					etm4_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in4>;
> +					};
>  				};
>  			};
>  		};
> @@ -336,10 +321,12 @@
>  
>  			cpu = <&cpu5>;
>  
> -			port {
> -				etm5_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in5>;
> +			out-ports {
> +				port {
> +					etm5_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in5>;
> +					};
>  				};
>  			};
>  		};
> @@ -353,10 +340,12 @@
>  
>  			cpu = <&cpu6>;
>  
> -			port {
> -				etm6_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in6>;
> +			out-ports {
> +				port {
> +					etm6_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in6>;
> +					};
>  				};
>  			};
>  		};
> @@ -370,10 +359,12 @@
>  
>  			cpu = <&cpu7>;
>  
> -			port {
> -				etm7_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in7>;
> +			out-ports {
> +				port {
> +					etm7_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in7>;
> +					};
>  				};
>  			};
>  		};
> 
