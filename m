From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 29 Feb 2016 15:43:56 +0000
Subject: [PATCH 2/8] clk: bcm2835: add missing PLL clock divider
In-Reply-To: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
References: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456760642-2412-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the missing pll clock divider definitions.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |   50 +++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/bcm2835.h |    8 ++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 01a48cb..710cf15 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1497,6 +1497,22 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.load_mask = CM_PLLA_LOADPER,
 		.hold_mask = CM_PLLA_HOLDPER,
 		.fixed_divider = 1),
+	[BCM2835_PLLA_DSI0]	= REGISTER_PLL_DIV(
+		.name = "plla_dsi0",
+		.source_pll = "plla",
+		.cm_reg = CM_PLLA,
+		.a2w_reg = A2W_PLLA_DSI0,
+		.load_mask = CM_PLLA_LOADDSI0,
+		.hold_mask = CM_PLLA_HOLDDSI0,
+		.fixed_divider = 1),
+	[BCM2835_PLLA_CCP2]	= REGISTER_PLL_DIV(
+		.name = "plla_ccp2",
+		.source_pll = "plla",
+		.cm_reg = CM_PLLA,
+		.a2w_reg = A2W_PLLA_DSI0,
+		.load_mask = CM_PLLA_LOADCCP2,
+		.hold_mask = CM_PLLA_HOLDCCP2,
+		.fixed_divider = 1),

 	/* PLLB is used for the ARM's clock. */
 	[BCM2835_PLLB]		= REGISTER_PLL(
@@ -1521,6 +1537,24 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.load_mask = CM_PLLB_LOADARM,
 		.hold_mask = CM_PLLB_HOLDARM,
 		.fixed_divider = 1),
+	[BCM2835_PLLB_SP0]	= REGISTER_PLL_DIV(
+		.name = "pllb_sp0",
+		.source_pll = "pllb",
+		.cm_reg = CM_PLLB,
+		.a2w_reg = A2W_PLLB_SP0,
+		.fixed_divider = 1),
+	[BCM2835_PLLB_SP1]	= REGISTER_PLL_DIV(
+		.name = "pllb_sp1",
+		.source_pll = "pllb",
+		.cm_reg = CM_PLLB,
+		.a2w_reg = A2W_PLLB_SP1,
+		.fixed_divider = 1),
+	[BCM2835_PLLB_SP2]	= REGISTER_PLL_DIV(
+		.name = "pllb_sp2",
+		.source_pll = "pllb",
+		.cm_reg = CM_PLLB,
+		.a2w_reg = A2W_PLLB_SP2,
+		.fixed_divider = 1),

 	/*
 	 * PLLC is the core PLL, used to drive the core VPU clock.
@@ -1611,6 +1645,22 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.load_mask = CM_PLLD_LOADPER,
 		.hold_mask = CM_PLLD_HOLDPER,
 		.fixed_divider = 1),
+	[BCM2835_PLLD_DSI0]	= REGISTER_PLL_DIV(
+		.name = "plld_dsi0",
+		.source_pll = "plld",
+		.cm_reg = CM_PLLD,
+		.a2w_reg = A2W_PLLD_DSI0,
+		.load_mask = CM_PLLD_LOADDSI0,
+		.hold_mask = CM_PLLD_HOLDDSI0,
+		.fixed_divider = 1),
+	[BCM2835_PLLD_DSI1]	= REGISTER_PLL_DIV(
+		.name = "plld_dsi1",
+		.source_pll = "plld",
+		.cm_reg = CM_PLLD,
+		.a2w_reg = A2W_PLLD_DSI1,
+		.load_mask = CM_PLLD_LOADDSI1,
+		.hold_mask = CM_PLLD_HOLDDSI1,
+		.fixed_divider = 1),

 	/*
 	 * PLLH is used to supply the pixel clock or the AUX clock for the
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index 9a7b4a5..9689812 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -45,3 +45,11 @@
 #define BCM2835_CLOCK_PERI_IMAGE	29
 #define BCM2835_CLOCK_PWM		30
 #define BCM2835_CLOCK_PCM		31
+
+#define BCM2835_PLLA_DSI0		32
+#define BCM2835_PLLA_CCP2		33
+#define BCM2835_PLLB_SP0		34
+#define BCM2835_PLLB_SP1		35
+#define BCM2835_PLLB_SP2		36
+#define BCM2835_PLLD_DSI0		37
+#define BCM2835_PLLD_DSI1		38
--
1.7.10.4
