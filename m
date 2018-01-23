From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 23 Jan 2018 17:32:33 +0530
Subject: [PATCH 4/6] ARM: davinci: move davinci_clk_init() to init_time
In-Reply-To: <1516418424-28686-5-git-send-email-david@lechnology.com>
References: <1516418424-28686-1-git-send-email-david@lechnology.com>
 <1516418424-28686-5-git-send-email-david@lechnology.com>
Message-ID: <5c3af565-58ba-25af-4154-6917c9477485@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 08:50 AM, David Lechner wrote:
> This moves the call of davinci_clk_init() from map_io to init_time for all
> boards.
> 
> This is the proper place to init clocks. This is also done in preparation
> for moving to the common clock framework.
> 
> dm646x is a special case because we need to handle different ref_clk rates
> depending on which board is being used. The clock init in this case is
> modified to set the rate before registering the clocks instead of using
> davinci_set_refclk_rate() to recalculate the entire clock tree after all
> of the clocks are registered.
> 
> Also, the cpu_clks field is removed from struct davinci_soc_info since it
> is no longer needed.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to my tree for v4.17

Thanks,
Sekhar
