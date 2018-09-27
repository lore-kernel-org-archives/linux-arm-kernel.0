From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 27 Sep 2018 09:18:06 +0100
Subject: [PATCH v2 05/11] arm64: dts: msm8916: Update coresight bindings
 for hardware ports
In-Reply-To: <20180912135352.19722-6-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-6-suzuki.poulose@arm.com>
Message-ID: <8ada229a-49ca-95ff-dc31-df459aaa7196@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy

On 09/12/2018 02:53 PM, Suzuki K Poulose wrote:
> Switch to updated coresight bindings for hw ports
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v1:
>   - Fixed TPIU port direction
>   - Use better subject tag for the patch
> ---


Please could you pull this and the patch for ARM (Patch 9/11)  ?

Suzuki



>   arch/arm64/boot/dts/qcom/msm8916.dtsi | 95 ++++++++++++++-------------
>   1 file changed, 51 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 7b32b8990d62..fe375a9c218e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1099,10 +1099,11 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			port {
> -				tpiu_in: endpoint {
> -					slave-mode;
> -					remote-endpoint = <&replicator_out1>;
> +			in-ports {
> +				port {
> +					tpiu_in: endpoint {
> +						remote-endpoint = <&replicator_out1>;
> +					};
>   				};
>   			};
>   		};
> @@ -1114,7 +1115,7 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			ports {
> +			in-ports {
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -1132,12 +1133,13 @@
>   				port at 4 {
>   					reg = <4>;
>   					funnel0_in4: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&funnel1_out>;
>   					};
>   				};
> -				port at 8 {
> -					reg = <0>;
> +			};
> +
> +			out-ports {
> +				port {
>   					funnel0_out: endpoint {
>   						remote-endpoint = <&etf_in>;
>   					};
> @@ -1152,7 +1154,7 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			ports {
> +			out-ports {
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -1168,10 +1170,11 @@
>   						remote-endpoint = <&tpiu_in>;
>   					};
>   				};
> -				port at 2 {
> -					reg = <0>;
> +			};
> +
> +			in-ports {
> +				port {
>   					replicator_in: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&etf_out>;
>   					};
>   				};
> @@ -1185,19 +1188,16 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port at 0 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>   					etf_in: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&funnel0_out>;
>   					};
>   				};
> -				port at 1 {
> -					reg = <0>;
> +			};
> +
> +			out-ports {
> +				port {
>   					etf_out: endpoint {
>   						remote-endpoint = <&replicator_in>;
>   					};
> @@ -1212,10 +1212,11 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			port {
> -				etr_in: endpoint {
> -					slave-mode;
> -					remote-endpoint = <&replicator_out0>;
> +			in-ports {
> +				port {
> +					etr_in: endpoint {
> +						remote-endpoint = <&replicator_out0>;
> +					};
>   				};
>   			};
>   		};
> @@ -1227,40 +1228,38 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			ports {
> +			in-ports {
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
>   				port at 0 {
>   					reg = <0>;
>   					funnel1_in0: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&etm0_out>;
>   					};
>   				};
>   				port at 1 {
>   					reg = <1>;
>   					funnel1_in1: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&etm1_out>;
>   					};
>   				};
>   				port at 2 {
>   					reg = <2>;
>   					funnel1_in2: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&etm2_out>;
>   					};
>   				};
>   				port at 3 {
>   					reg = <3>;
>   					funnel1_in3: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&etm3_out>;
>   					};
>   				};
> -				port at 4 {
> -					reg = <0>;
> +			};
> +
> +			out-ports {
> +				port {
>   					funnel1_out: endpoint {
>   						remote-endpoint = <&funnel0_in4>;
>   					};
> @@ -1309,9 +1308,11 @@
>   
>   			cpu = <&CPU0>;
>   
> -			port {
> -				etm0_out: endpoint {
> -				remote-endpoint = <&funnel1_in0>;
> +			out-ports {
> +				port {
> +					etm0_out: endpoint {
> +						remote-endpoint = <&funnel1_in0>;
> +					};
>   				};
>   			};
>   		};
> @@ -1325,9 +1326,11 @@
>   
>   			cpu = <&CPU1>;
>   
> -			port {
> -				etm1_out: endpoint {
> -					remote-endpoint = <&funnel1_in1>;
> +			out-ports {
> +				port {
> +					etm1_out: endpoint {
> +						remote-endpoint = <&funnel1_in1>;
> +					};
>   				};
>   			};
>   		};
> @@ -1341,9 +1344,11 @@
>   
>   			cpu = <&CPU2>;
>   
> -			port {
> -				etm2_out: endpoint {
> -					remote-endpoint = <&funnel1_in2>;
> +			out-ports {
> +				port {
> +					etm2_out: endpoint {
> +						remote-endpoint = <&funnel1_in2>;
> +					};
>   				};
>   			};
>   		};
> @@ -1357,9 +1362,11 @@
>   
>   			cpu = <&CPU3>;
>   
> -			port {
> -				etm3_out: endpoint {
> -					remote-endpoint = <&funnel1_in3>;
> +			out-ports {
> +				port {
> +					etm3_out: endpoint {
> +						remote-endpoint = <&funnel1_in3>;
> +					};
>   				};
>   			};
>   		};
> 
