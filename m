From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Jul 2017 14:00:15 -0700
Subject: [PATCH 2/2] arm64: dts: Add device node for pmi8994 gpios
In-Reply-To: <1501137036-20155-2-git-send-email-vivek.gautam@codeaurora.org>
References: <1501137036-20155-1-git-send-email-vivek.gautam@codeaurora.org>
 <1501137036-20155-2-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <f0ad95d2-f79e-c3d4-1ac6-48d5d6e21956@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2017 11:30 PM, Vivek Gautam wrote:
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/pmi8994.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
> index d3879a4e8076..3b04ca63c31e 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
> @@ -8,6 +8,23 @@
>  		reg = <0x2 SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +
> +		pmi8994_gpios: gpios at c000 {
> +			compatible = "qcom,pmi8994-gpio";


Please also include the generic "qcom,spmi-gpio" compatible. We really
don't need to add the "qcom,pmi8994-gpio" one to the driver right now so
I would leave that out of the driver but leave it here in the dtsi file
of course.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
