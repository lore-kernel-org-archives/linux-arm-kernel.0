From: michal.simek@xilinx.com (Michal Simek)
Date: Wed,  5 Feb 2014 15:56:37 +0100
Subject: [PATCH] ARM: zynq: Move of_clk_init from clock driver
Message-ID: <572af6e4eaaaa1c74ea62364f8fa7ac5834cc754.1391612175.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move of_clk_init() from clock driver to enable
options not to use zynq clock driver.
Use for example fixed clock setting.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on http://www.spinics.net/lists/arm-kernel/msg298287.html
series

---
 arch/arm/mach-zynq/common.c | 1 +
 drivers/clk/zynq/clkc.c     | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 93ea19b..8df35f3 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -68,6 +68,7 @@ static void __init zynq_timer_init(void)
 	zynq_early_slcr_init();

 	zynq_clock_init();
+	of_clk_init(NULL);
 	clocksource_of_init();
 }

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 03052d6..c812b93 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -602,8 +602,6 @@ void __init zynq_clock_init(void)
 	of_node_put(slcr);
 	of_node_put(np);

-	of_clk_init(NULL);
-
 	return;

 np_err:
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/55aa2bd7/attachment.sig>
