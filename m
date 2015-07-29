From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 29 Jul 2015 15:55:00 -0700
Subject: [PATCH v1 1/7] ARM: dts: ifc6410: Add pwrseq support for WLAN
In-Reply-To: <1438088022-17350-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088022-17350-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <55B959C4.2090600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2015 05:53 AM, Srinivas Kandagatla wrote:
> +
> +		sdcc4_pwrseq:pwrseq {

Missing space here between label and node name.

> +			compatible = "mmc-pwrseq-simple";
> +			reset-gpios = <&pm8921_gpio 43 GPIO_ACTIVE_LOW>;
> +		};
> +

Also this node is not part of the SoC so it should be in the root, 
possibly under some sort of power-sequences node so that all the 
sequences are grouped in one place.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
