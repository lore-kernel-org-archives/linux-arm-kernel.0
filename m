From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun,  7 Feb 2016 22:13:03 +0100
Subject: [PATCH] clk: meson: Fix meson_clk_register_clks() signature type
 mismatch
Message-ID: <1454879583-27036-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As preparation for arm64 based mesongxbb, which pulls in this code once
enabling ARCH_MESON, fix a size_t vs. unsigned int type mismatch.
The loop uses a local unsigned int variable, so adopt that type,
matching the header.

Fixes: 7a29a869434e ("clk: meson: Add support for Meson clock controller")
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 drivers/clk/meson/clkc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clkc.c b/drivers/clk/meson/clkc.c
index c83ae1367abc..d920d410b51d 100644
--- a/drivers/clk/meson/clkc.c
+++ b/drivers/clk/meson/clkc.c
@@ -198,7 +198,7 @@ meson_clk_register_fixed_rate(const struct clk_conf *clk_conf,
 }
 
 void __init meson_clk_register_clks(const struct clk_conf *clk_confs,
-				    size_t nr_confs,
+				    unsigned int nr_confs,
 				    void __iomem *clk_base)
 {
 	unsigned int i;
-- 
2.6.2
