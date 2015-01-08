From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 08 Jan 2015 13:23:13 -0800
Subject: [PATCH 2/2] clk: exynos-audss: Fix memory leak on driver unbind
 or probe failure
In-Reply-To: <1420451561-12360-2-git-send-email-k.kozlowski@samsung.com>
References: <1420451561-12360-1-git-send-email-k.kozlowski@samsung.com>
 <1420451561-12360-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54AEF541.1090700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2015 01:52 AM, Krzysztof Kozlowski wrote:
> The memory allocated by basic clock divider/gate/mux (struct clk_gate,
> clk_divider and clk_mux) was leaking. During driver unbind or probe
> failure the driver only unregistered the clocks.
>
> Use clk_unregister_{gate,divider,mux} to release all resources.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
