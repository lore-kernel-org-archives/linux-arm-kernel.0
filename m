From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 15:15:28 -0700
Subject: [PATCH v2] clk: Add clk_composite_set_rate_and_parent
In-Reply-To: <1460450619-1118-1-git-send-email-finley.xiao@rock-chips.com>
References: <1460339652-63498-1-git-send-email-finley.xiao@rock-chips.com>
 <1460450619-1118-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <20160415221528.GO14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12, Finlye Xiao wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> When changing the clock-rate, currently a new parent is set first and a
> divider adapted thereafter. This may result in the clock-rate overflowing
> its target rate for a short time if the new parent has a higher rate than
> the old parent.
> 
> While this often doesn't produce negative effects, it can affect components
> in a voltage-scaling environment, like the GPU on the rk3399 socs, where
> the voltage than simply is to low for the temporarily to high clock rate.
> 
> For general clock hirarchies this may need more extensive adaptions to
> the common clock-framework, but at least for composite clocks having
> both parent and rate settings it is easy to create a short-term solution to
> make sure the clock-rate does not overflow the target.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
