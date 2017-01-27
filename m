From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Jan 2017 16:12:50 -0800
Subject: [PATCH 1/2] clk: sunxi-ng: Call divider_round_rate if we only
 have a single parent
In-Reply-To: <53c56d23af099d8a41460d5ac59a2c792c8d050c.1485250845.git-series.maxime.ripard@free-electrons.com>
References: <53c56d23af099d8a41460d5ac59a2c792c8d050c.1485250845.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170127001250.GQ8801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24, Maxime Ripard wrote:
> The divider_get_val function that is used in our determine_rate callback
> doesn't try to change the parent rate at all, while clk_divider_bestdiv,
> used in divider_round_rate, does.
> 
> If we have a single parent, call divider_round_rate.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
