From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 May 2013 14:44:05 -0600
Subject: [PATCH v4 4/5] clk: add CLK_SET_RATE_NO_REPARENT flag
In-Reply-To: <1369056507-32521-5-git-send-email-james.hogan@imgtec.com>
References: <1369056507-32521-1-git-send-email-james.hogan@imgtec.com>
 <1369056507-32521-5-git-send-email-james.hogan@imgtec.com>
Message-ID: <519A8B15.4040702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2013 07:28 AM, James Hogan wrote:
> Add a CLK_SET_RATE_NO_REPARENT clock flag, which will prevent muxes
> being reparented during clk_set_rate.
> 
> To avoid breaking existing platforms, all callers of clk_register_mux()
> are adjusted to pass the new flag. Platform maintainers are encouraged
> to remove the flag if they wish to allow mux reparenting on set_rate.

The Tegra parts,
Acked-by: Stephen Warren <swarren@nvidia.com>
