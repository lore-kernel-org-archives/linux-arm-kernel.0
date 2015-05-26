From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 26 May 2015 14:26:39 +0200
Subject: [PATCH] clk: mvebu: add missing CESA gate clk
Message-ID: <1432643199-15507-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if not documented in the datasheet, the Armada 370 SoC can actually
gate the CESA (crypto engine) clock.
Add an entry in the gating_desc table to be able to reference the CESA
gateclk in the crypto node.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/clk/mvebu/armada-370.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
index 756f0f3..989c704 100644
--- a/drivers/clk/mvebu/armada-370.c
+++ b/drivers/clk/mvebu/armada-370.c
@@ -163,6 +163,7 @@ static const struct clk_gating_soc_desc a370_gating_desc[] __initconst = {
 	{ "pex1", "pex1_en", 9, 0 },
 	{ "sata0", NULL, 15, 0 },
 	{ "sdio", NULL, 17, 0 },
+	{ "cesa", NULL, 23, 0 },
 	{ "tdm", NULL, 25, 0 },
 	{ "ddr", NULL, 28, CLK_IGNORE_UNUSED },
 	{ "sata1", NULL, 30, 0 },
-- 
1.9.1
