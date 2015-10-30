From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Oct 2015 15:20:51 +0100
Subject: [PATCH 05/19] clk: sunxi: add DRAM gates
In-Reply-To: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1446214865-3972-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner SoCs have a gate controller to gate the access to the DRAM
clock to the some devices that need to access the DRAM directly (mostly
display / image related IPs).

Use a simple gates driver to support it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-simple-gates.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index 0214c6548afd..5666c767fa14 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -112,6 +112,8 @@ CLK_OF_DECLARE(sun5i_a13_apb0, "allwinner,sun5i-a13-apb0-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun5i_a13_apb1, "allwinner,sun5i-a13-apb1-gates-clk",
 	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun5i_a13_dram, "allwinner,sun5i-a13-dram-gates-clk",
+	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun6i_a31_ahb1, "allwinner,sun6i-a31-ahb1-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun6i_a31_apb1, "allwinner,sun6i-a31-apb1-gates-clk",
-- 
2.6.2
