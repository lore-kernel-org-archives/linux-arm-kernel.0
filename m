From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 14 Nov 2016 15:42:34 +0100
Subject: [PATCH] arm64: dts: rockchip: add gmac needed clk for rk3399 pd
In-Reply-To: <1479098199-20170-1-git-send-email-wxt@rock-chips.com>
References: <1479098199-20170-1-git-send-email-wxt@rock-chips.com>
Message-ID: <15590097.XDc0ARC38n@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 14. November 2016, 12:36:39 CET schrieb Caesar Wang:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> This patch fixes that sometimes hang at start-up time of the system.
> As the below log:
> ...
> [   11.136543] calling  pm_genpd_debug_init+0x0/0x60 @ 1
> [   11.141602] initcall pm_genpd_debug_init+0x0/0x60 returned 0 after 11
> usecs [   11.148558] calling  genpd_poweroff_unused+0x0/0x84 @ 1
> <hang>
> 
> In some cases, the rk3399 should turn off the gmac power domain to save
> power if some boards didn't register the gmac device node for rk3399.
> Then, rk3399 need to make sure the gmac's pclk enabled if we need
> operate the gmac power domain. (Due to the NOC had enabled always)
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts64 branch


Thanks
Heiko
