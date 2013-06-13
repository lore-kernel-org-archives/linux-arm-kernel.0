From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Jun 2013 18:35:14 -0700
Subject: [PATCH v4 0/5] clk: implement remuxing during set_rate
In-Reply-To: <1369056507-32521-1-git-send-email-james.hogan@imgtec.com>
References: <1369056507-32521-1-git-send-email-james.hogan@imgtec.com>
Message-ID: <51B921D2.2030700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/13 06:28, James Hogan wrote:
> This patchset adds support for automatic selection of the best parent
> for a clock mux, i.e. the one which can provide the closest clock rate
> to that requested. It can be disabled by a new CLK_SET_RATE_NO_REPARENT
> flag (which is set for all uses of clk_register_mux().
>
> This works by way of adding a new op, determine_rate, similar to
> round_rate but with an extra parameter to allow the clock driver to
> optionally select a different parent clock. This is used in
> clk_calc_new_rates to decide whether to initiate a set_parent operation.

I'd like to see this go into 3.11. We can tackle the larger problem that
Saravana brought up later on since we're no worse off than we already
are without these patches.

Feel free to add my reviewed-by to all patches.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
