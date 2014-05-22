From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 22 May 2014 11:32:28 -0500
Subject: [PATCH v1 5/5] ARM: dts: qcom: Add APQ8084 serial port DT node
In-Reply-To: <1400775885-10296-6-git-send-email-gdjakov@mm-sol.com>
References: <1400775885-10296-1-git-send-email-gdjakov@mm-sol.com>
 <1400775885-10296-6-git-send-email-gdjakov@mm-sol.com>
Message-ID: <693A0E52-34CF-4A63-A8D0-A83780F969F0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 22, 2014, at 11:24 AM, Georgi Djakov <gdjakov@mm-sol.com> wrote:

> Add the necessary DT node to probe the serial driver on
> APQ8084 platforms.
> 
> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
> ---
> arch/arm/boot/dts/qcom-apq8084.dtsi |    7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
> index 2dcd11e..c346549 100644
> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
> @@ -185,5 +185,12 @@
> 			reg = <0xfc400000 0x4000>;
> 		};
> 
> +		serial at f995e000 {

Mark it disabled in the soc.dtsi and ?ok? in the board.

> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0xf995e000 0x1000>;
> +			interrupts = <0 114 0x0>;
> +			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
> +			clock-names = "core", "iface";
> +		};
> 	};
> };
> -- 
> 1.7.9.5
> 

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
