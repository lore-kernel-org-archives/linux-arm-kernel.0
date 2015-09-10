From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 10 Sep 2015 13:56:16 -0700
Subject: [PATCH] clk: rockchip: handle critical clocks after registrering
 all clocks
In-Reply-To: <7786473.0oe27txQFN@phil>
References: <7786473.0oe27txQFN@phil>
Message-ID: <20150910205616.GD15099@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21, Heiko Stuebner wrote:
> Currently the registration of critical clocks is done in the function
> shared between rk3066 and rk3188 clock trees. That results in them
> getting handled maybe before all of them are registered.
> 
> Therefore move the critical clock handling down to the end of the soc-
> specific clock registration function, so that all clocks are registered
> before they're maybe handled as critical clock.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
