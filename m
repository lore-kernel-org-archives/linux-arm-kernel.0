From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 12:07:43 -0800
Subject: [PATCH 1/2] clk: rename clk_core_get_boundaries() to
 clk_hw_get_boundaries() and expose
In-Reply-To: <1513872282-5370-2-git-send-email-al.kochet@gmail.com>
References: <1513872282-5370-1-git-send-email-al.kochet@gmail.com>
 <1513872282-5370-2-git-send-email-al.kochet@gmail.com>
Message-ID: <20171221200743.GM7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21, Alexander Kochetkov wrote:
> In order to provide a way to know clock limits to clock providers.
> 
> The patch is needed for fixing commit 5d890c2df900 ("clk: rockchip:
> add special approximation to fix up fractional clk's jitter").
> Custom approximation function introduced by the patch, can
> select frequency rate larger than one configured using
> clk_set_max_rate().
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---

Can you convert to the determine_rate op instead of round_rate?
That function should tell you the min/max limits so that you
don't need to query that information from the core.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
