From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 13 Mar 2014 16:08:01 -0500
Subject: [PATCH] clk: socfpga: Fix section mismatch warning
Message-ID: <1394744881-15254-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

WARNING: drivers/clk/socfpga/built-in.o(.data+0xc0): Section mismatch in
reference from the variable socfpga_child_clocks to the function
.init.text:socfpga_pll_init()
The variable socfpga_child_clocks references
the function __init socfpga_pll_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: drivers/clk/socfpga/built-in.o(.data+0x184): Section mismatch in
reference from the variable socfpga_child_clocks to the function
.init.text:socfpga_periph_init()
The variable socfpga_child_clocks references
the function __init socfpga_periph_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: drivers/clk/socfpga/built-in.o(.data+0x248): Section mismatch in
reference from the variable socfpga_child_clocks to the function
.init.text:socfpga_gate_init()
The variable socfpga_child_clocks references
the function __init socfpga_gate_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Reported-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 drivers/clk/socfpga/clk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 6217d5d..35a960a 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -28,7 +28,7 @@
 
 void __iomem *clk_mgr_base_addr;
 
-static struct of_device_id socfpga_child_clocks[] = {
+static const struct of_device_id socfpga_child_clocks[] __initconst = {
 	{ .compatible = "altr,socfpga-pll-clock", socfpga_pll_init, },
 	{ .compatible = "altr,socfpga-perip-clk", socfpga_periph_init, },
 	{ .compatible = "altr,socfpga-gate-clk", socfpga_gate_init, },
-- 
1.7.9.5
