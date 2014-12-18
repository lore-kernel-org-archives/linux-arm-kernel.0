From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Dec 2014 19:40:15 +0000
Subject: [PATCH] clk: rockchip: fix rk3288 cpuclk core dividers
In-Reply-To: <1590307.oZ7E5cNY8h@phil>
References: <1590307.oZ7E5cNY8h@phil>
Message-ID: <20141218194015.GC11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 08:22:34PM +0100, Heiko St?bner wrote:
> Commit 0e5bdb3f9fa5 (clk: rockchip: switch to using the new cpuclk type
> for armclk) didn't take into account that the divider used on rk3288
> are of the (n+1) type.
> 
> The rk3066 and rk3188 socs use more complex divider types making it
> necessary for the list-elements to be the real register-values to write.
> 
> Therefore reduce divider values in the table accordingly so that they
> really are the values that should be written to the registers.
> 
> Reported-by: Sonny Rao <sonnyrao@chromium.org>
> Fixes: 0e5bdb3f9fa5

The correct format for this is:

Fixes: <12-digits-of-sha> ("<commit-comment>")

where everything between and including the <> gets replaced.  The () and ""
stay.  In other words:

Fixes: 0e5bdb3f9fa5 ("clk: rockchip: switch to using the new cpuclk type for armclk")

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
