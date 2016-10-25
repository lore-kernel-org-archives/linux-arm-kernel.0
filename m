From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Oct 2016 13:36:04 -0700
Subject: [PATCH v2 3/4] clk: imx31: fix rewritten input argument of
 mx31_clocks_init()
In-Reply-To: <1474848223-19728-4-git-send-email-vz@mleia.com>
References: <1474848223-19728-1-git-send-email-vz@mleia.com>
 <1474848223-19728-4-git-send-email-vz@mleia.com>
Message-ID: <20161025203604.GB26139@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26, Vladimir Zapolskiy wrote:
> Function mx31_clocks_init() is called during clock intialization on
> legacy boards with reference clock frequency passed as its input
> argument, this can be verified by examination of the function
> declaration found in arch/arm/mach-imx/common.h and actual function
> users which include that header file.
> 
> Inside CCF driver the function ignores its input argument, by chance
> the used value in the function body is the same as input arguments on
> side of all callers.
> 
> Fixes: d9388c843237 ("clk: imx31: Do not call mxc_timer_init twice when booting with DT")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
