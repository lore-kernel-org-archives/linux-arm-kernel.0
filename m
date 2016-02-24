From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Feb 2016 15:06:40 -0800
Subject: [PATCH v3 6/8] arm64: dts: qcom: fix usb digital voltage levels
In-Reply-To: <1456246236-18341-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1456246236-18341-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <56CE3780.5060408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2016 08:50 AM, Srinivas Kandagatla wrote:
> This patch updates the digital voltage levels from corner values to
> microvolts as we are going to use s1 regulator directly for vddcx
> instead of s1_corner.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

What's the plan for corners? Maybe we should remove the voltage setting
from the usb driver or drop the usb node entirely on msm8916 until we
resolve how we're going to handle corners. I'd like to avoid getting
stuck into some DT binding ABI mess here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
