From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 13 Aug 2015 16:18:14 -0700
Subject: [PATCH 1/3] ARM: qcom: add SFPB nodes to IPQ806x dts
In-Reply-To: <1439501620-24073-2-git-send-email-mathieu@codeaurora.org>
References: <1439501620-24073-1-git-send-email-mathieu@codeaurora.org>
 <1439501620-24073-2-git-send-email-mathieu@codeaurora.org>
Message-ID: <55CD25B6.6050901@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2015 02:33 PM, Mathieu Olivari wrote:
> Add one new node to the ipq806x.dtsi file to declare & register the
> hardware spinlock devices. This mechanism is required to be used by
> other drivers such as SMEM.
>
> Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
> ---
>   arch/arm/boot/dts/qcom-ipq8064.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 9f727d8..ea7b959 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -67,6 +67,18 @@
>   			clock-frequency = <32768>;
>   			#clock-cells = <0>;
>   		};
> +
> +		sfpb_mutex_block: syscon at 01200600 {

I think you can drop the leading 0 here. Also this should be moved into 
the soc node.

> +			compatible = "syscon";
> +			reg = <0x01200600 0x100>;
> +		};
> +
> +		sfpb_mutex: sfpb-mutex {
> +			compatible = "qcom,sfpb-mutex";
> +			syscon = <&sfpb_mutex_block 4 4>;
> +
> +			#hwlock-cells = <1>;
> +		};

And this node should be moved to the root /.
>   	};
>   
>   	soc: soc {


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
