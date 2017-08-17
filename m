From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 17 Aug 2017 14:06:30 -0700
Subject: [PATCH] usb: dwc3: of-simple: remove include of clk-provider.h
In-Reply-To: <1502634071-2266-1-git-send-email-shawnguo@kernel.org>
References: <1502634071-2266-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20170817210630.GH2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> The header clk-provider.h is there for clock drivers (providers) to
> include, not client drivers (consumers).  That said,
> of_clk_get_parent_count() is a helper function for clock providers, not
> a clk API for consumers.
> 
> Let's replace of_clk_get_parent_count() with of_count_phandle_with_args()
> call, so that we can remove the include of clk-provider.h.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
