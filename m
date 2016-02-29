From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 29 Feb 2016 15:44:02 +0000
Subject: [PATCH 8/8] clk: bcm2835: add the testdebug clock generators
In-Reply-To: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
References: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456760642-2412-9-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the testdebug0/1 clock generators using the osc parent mux.

These may also require PM_DEBUG to work propperly.
Also the parents are - for now - unclear, so we assume osc parents.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |   19 +++++++++++++++++++
 include/dt-bindings/clock/bcm2835.h |    2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 2ddff8f..926fdf5 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1865,6 +1865,25 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.div_reg = CM_TECDIV,
 		.int_bits = 6,
 		.frac_bits = 0),
+	/*
+	 * testdebug clocks
+	 * these may possibly require PM_DEBUG to be set as well
+	 * for now we assume these are using the osc parent mux
+	 * (note that testdebugX is in this mux as well,
+	 * so it may produce issues)
+	 */
+	[BCM2835_CLOCK_TESTDEBUG0] = REGISTER_OSC_CLK(
+		.name = "testdebug0",
+		.ctl_reg = CM_TD0CTL,
+		.div_reg = CM_TD0DIV,
+		.int_bits = 12,
+		.frac_bits = 12),
+	[BCM2835_CLOCK_TESTDEBUG0] = REGISTER_OSC_CLK(
+		.name = "testdebug1",
+		.ctl_reg = CM_TD1CTL,
+		.div_reg = CM_TD1DIV,
+		.int_bits = 12,
+		.frac_bits = 12),

 	/* clocks with vpu parent mux */
 	[BCM2835_CLOCK_H264]	= REGISTER_VPU_CLK(
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index 7bc03cd..c752392 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -73,3 +73,5 @@
 #define BCM2835_CLOCK_ARM		55
 #define BCM2835_CLOCK_PERA		56
 #define BCM2835_CLOCK_SYS		57
+#define BCM2835_CLOCK_TESTDEBUG0	58
+#define BCM2835_CLOCK_TESTDEBUG1	59
--
1.7.10.4
