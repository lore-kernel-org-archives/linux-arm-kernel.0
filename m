From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jan 2016 22:50:43 +0100
Subject: [PATCH] [BUG] clk: rockchip: don't mark clock names as initconst
In-Reply-To: <1799610.nrn5HMCSxL@diego>
References: <2791943.MBZ53mI7Gp@wuerfel> <1799610.nrn5HMCSxL@diego>
Message-ID: <6692523.e5K11FUKe0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 January 2016 18:06:30 Heiko St?bner wrote:
> 
> "[PATCH] clk: rockchip: fix section mismatches with new child-clocks" [0]
> 
> should be in Mike's + Stephen's inbox since last week as well, which moves the 
> offending new elements into separate entities, which can have __initdata 
> attributes again.
> 
> 
> Heiko
> 
> [0] http://www.spinics.net/lists/arm-kernel/msg471295.html

The patch looks good, but for some reason, the next-20151223 kernel had no
problem and next-20151231 was broken, the top commits in drivers/clk/rockchips
are:

commit a915e30dd26ea5f3cc2e2c044aba38ee5973d3fa
Merge: ce6dd266d535 b0158bb27c7b
Author: Michael Turquette <mturquette@baylibre.com>
Date:   Wed Dec 23 13:08:56 2015 -0800

    Merge branch 'clk-rockchip' into clk-next

commit b0158bb27c7b6e9843f541c17b24dbd964b76db6
Author: Xing Zheng <zhengxing@rock-chips.com>
Date:   Tue Dec 22 22:28:01 2015 +0100

    clk: rockchip: rk3036: include downstream muxes into fractional dividers
    
    Use the newly introduced possibility to combine the fractional dividers


	Arnd
