From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Feb 2017 23:19:51 -0800
Subject: [PATCH] arm64: dts: apq8016-sbc: Add ramoops
In-Reply-To: <20170201102424.4017-1-bjorn.andersson@linaro.org>
References: <20170201102424.4017-1-bjorn.andersson@linaro.org>
Message-ID: <20170228071951.GH25384@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01, Bjorn Andersson wrote:
> Declare a ramoops memory segment to aid debugging for those without UART
> access. Verified to carry console log when holding volume down for 15
> seconds.
> 
> I was unable to find any ramoops-like memory region used in the 8916
> downstream kernels, so the picked region is the last MB in System RAM.
> 
> No memory region for ramoops-like support was found downstrea, so the
> arbitrarily picked region is the last MB of System RAM.

Same comment twice? Otherwise it looks ok to me as long as you're
willing to lose an MB of ram. Does the kernel skip reserving the
ramoops memory if ramoops isn't enabled? That would be nice to do
so we don't lose memory if we're not enabling the driver.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
