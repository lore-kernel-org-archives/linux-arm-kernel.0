From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 8 Feb 2016 14:43:28 -0800
Subject: [PATCH v3 5/6] dts: ipq4019: Add support for IPQ4019 DK01 board
In-Reply-To: <1447975173-29485-6-git-send-email-mmcclint@qca.qualcomm.com>
References: <1447975173-29485-1-git-send-email-mmcclint@qca.qualcomm.com>
 <1447975173-29485-6-git-send-email-mmcclint@qca.qualcomm.com>
Message-ID: <20160208224328.GB10791@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19, Matthew McClintock wrote:
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK01.1";
> +	compatible = "qcom,ipq4019";
> +
> +	clocks {
> +                xo: xo {
> +                        compatible = "fixed-clock";
> +                        clock-frequency = <48000000>;
> +                        #clock-cells = <0>;
> +                };
> +	};

Is there a reason the xo is here and the sleep clk is in the SoC
dtsi file? Both are board clocks so I would think they would be
added in the same place.

> +
> +	soc {
> +
> +
> +		timer {
> +			compatible = "arm,armv7-timer";
> +			interrupts = <1 2 0xf08>,
> +				     <1 3 0xf08>,
> +				     <1 4 0xf08>,
> +				     <1 1 0xf08>;
> +			clock-frequency = <48000000>;
> +		};

The timer shouldn't be part of the SoC node (it has no reg property).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
