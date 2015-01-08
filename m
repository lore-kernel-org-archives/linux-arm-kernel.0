From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 08 Jan 2015 13:22:42 -0800
Subject: [PATCH 1/2] clk: Add clk_unregister_{divider,gate,mux} to close
 memory leak
In-Reply-To: <1420451561-12360-1-git-send-email-k.kozlowski@samsung.com>
References: <1420451561-12360-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54AEF522.1060904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2015 01:52 AM, Krzysztof Kozlowski wrote:
> The common clk_register_{divider,gate,mux} functions allocated memory
> for internal data which wasn't freed anywhere. Drivers using these
> helpers could only unregister clocks but the memory would still leak.
>
> Add corresponding unregister functions which will release all resources.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

We're trying to move away from struct clk in provider APIs. It would be
nice to have these functions take the clk_hw pointer instead, but I
guess that can come later.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
