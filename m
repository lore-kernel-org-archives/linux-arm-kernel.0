From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 27 Aug 2014 00:54:56 +0200
Subject: [PATCH 2/2] clk: rockchip: make rockchip_clk_register_branch static
In-Reply-To: <2167469.H3nkUqR3zE@diego>
References: <2167469.H3nkUqR3zE@diego>
Message-ID: <2007363.F5C6XFFCpC@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is only used locally in clk/rockchip/clk.c and thus can be static.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 5db1ecf..5c9abd7 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -37,7 +37,7 @@
  *
  * sometimes without one of those components.
  */
-struct clk *rockchip_clk_register_branch(const char *name,
+static struct clk *rockchip_clk_register_branch(const char *name,
 		const char **parent_names, u8 num_parents, void __iomem *base,
 		int muxdiv_offset, u8 mux_shift, u8 mux_width, u8 mux_flags,
 		u8 div_shift, u8 div_width, u8 div_flags,
-- 
2.0.1
