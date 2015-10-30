From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Oct 2015 15:20:52 +0100
Subject: [PATCH 06/19] clk: sunxi: Add Allwinner R8 AHB gates support
In-Reply-To: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1446214865-3972-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R8 has yet another array of gates for AHB. Let's add it to the list of
compatibles we can deal with.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-simple-gates.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index 5666c767fa14..e3190a8687a8 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -158,5 +158,7 @@ CLK_OF_DECLARE(sun5i_a10s_ahb, "allwinner,sun5i-a10s-ahb-gates-clk",
 	       sun4i_a10_ahb_init);
 CLK_OF_DECLARE(sun5i_a13_ahb, "allwinner,sun5i-a13-ahb-gates-clk",
 	       sun4i_a10_ahb_init);
+CLK_OF_DECLARE(sun5i_r8_ahb, "allwinner,sun5i-r8-ahb-gates-clk",
+	       sun4i_a10_ahb_init);
 CLK_OF_DECLARE(sun7i_a20_ahb, "allwinner,sun7i-a20-ahb-gates-clk",
 	       sun4i_a10_ahb_init);
-- 
2.6.2
