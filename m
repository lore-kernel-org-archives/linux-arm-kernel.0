From: architt@codeaurora.org (Archit Taneja)
Date: Fri, 18 Aug 2017 09:51:04 +0530
Subject: [PATCH] ARM: dts: qcom-apq8064: Fix dsi and hdmi phy cells
In-Reply-To: <1502857706-18379-1-git-send-email-andy.gross@linaro.org>
References: <1502857706-18379-1-git-send-email-andy.gross@linaro.org>
Message-ID: <ae7f9349-9600-5798-2485-bffa54458b34@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/16/2017 09:58 AM, Andy Gross wrote:
> This patch adds the necessary #phy-cells property to the DSI and HDMI
> phys.
The DSI and HDMI drivers don't use the common PHY framework, so we end up
being okay without #phy-cells. But we do follow the PHY DT bindings, so it's
necessary in that sense.

Reviewed-by: Archit Taneja <architt@codeaurora.org>

> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>   arch/arm/boot/dts/qcom-apq8064.dtsi | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index f3db185..d08f3db 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -906,11 +906,11 @@
>   				usb_hs1_phy: phy {
>   					compatible = "qcom,usb-hs-phy-apq8064",
>   						     "qcom,usb-hs-phy";
> -					#phy-cells = <0>;
>   					clocks = <&sleep_clk>, <&cxo_board>;
>   					clock-names = "sleep", "ref";
>   					resets = <&usb1 0>;
>   					reset-names = "por";
> +					#phy-cells = <0>;
>   				};
>   			};
>   		};
> @@ -1263,6 +1263,7 @@
>   		dsi0_phy: dsi-phy at 4700200 {
>   			compatible = "qcom,dsi-phy-28nm-8960";
>   			#clock-cells = <1>;
> +			#phy-cells = <0>;
>   
>   			reg = <0x04700200 0x100>,
>   				<0x04700300 0x200>,
> @@ -1417,6 +1418,7 @@
>   
>   			clocks = <&mmcc HDMI_S_AHB_CLK>;
>   			clock-names = "slave_iface_clk";
> +			#phy-cells = <0>;
>   		};
>   
>   		mdp: mdp at 5100000 {
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
