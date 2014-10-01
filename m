From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 1 Oct 2014 10:28:55 -0700
Subject: [PATCH 2/4] ARM: qcom: add description of KPSS WDT for IPQ8064
In-Reply-To: <50c0ec1514173ce07641a95839e939dcda41b110.1412182773.git.joshc@codeaurora.org>
References: <cover.1412182773.git.joshc@codeaurora.org>
 <50c0ec1514173ce07641a95839e939dcda41b110.1412182773.git.joshc@codeaurora.org>
Message-ID: <20141001172855.GL10233@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01, Josh Cartwright wrote:
> @@ -96,6 +104,13 @@
>  			cpu-offset = <0x80000>;
>  		};
>  
> +		watchdog at 208a038 {
> +			compatible = "qcom,kpss-wdt-ipq8064";
> +			reg = <0x0208a038 0x40>;

Not being aligned to 4k or 1k raises red flags.

The watchdog is part of the timer block (on this chip it's
"qcom,kpss-timer"). We should add qcom,kpss-wdt to the compatible
list in the timer binding and extend that binding to have clocks
and timeout-sec (watchdog-timeout-sec?). This would follow DT
best practices of having one node per device. We could also add
the interrupts too, even if they're not used by the driver right
now.

> +			clocks = <&sleep_clk>;
> +			timeout-sec = <10>;
> +		};
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
