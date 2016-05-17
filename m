From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 17 May 2016 23:10:51 +0200
Subject: [PATCH 1/2] clk: rockchip: mark rk3399 GIC clocks as critical
In-Reply-To: <1463164937-91089-1-git-send-email-briannorris@chromium.org>
References: <1463164937-91089-1-git-send-email-briannorris@chromium.org>
Message-ID: <2111538.t2M7m4hXj2@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 13. Mai 2016, 11:42:16 schrieb Brian Norris:
> We never want to kill the GIC.
> 
> Noticed when making other clock fixups, and seeing the newly-constructed
> clock tree try to disable cpll, where we had this parent structure:
> 
>   aclk_gic <------\
> 
>                   |--- aclk_gic_pre <-- cpll <-- pll_cpll
> 
>   aclk_gic_noc <--/
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

applied both patches to my clk-fixes branch with Dougs review-tags.


Thanks
Heiko
