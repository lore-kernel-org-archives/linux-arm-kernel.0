From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Jun 2011 13:35:22 +0200
Subject: [PATCH 4/6] mach-ux500: Add pin configuration for snowball board
Message-ID: <1308742522-24974-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Marklund <robert.marklund@stericsson.com>

This sets up a few GPIO pins and some pinmuxing on platform boot
for the Snowball board. Based on work from Mathieu J. Poirier
<mathieu.poirier@linaro.org>.

Signed-off-by: Robert Marklund <robert.marklund@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-pins.c |   43 +++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index fd4cf1c..7013d00 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -228,6 +228,46 @@ static pin_cfg_t mop500_pins_hrefv60[] = {
 
 };
 
+static pin_cfg_t snowball_pins[] = {
+	/* SSP0, to AB8500 */
+	GPIO143_SSP0_CLK,
+	GPIO144_SSP0_FRM,
+	GPIO145_SSP0_RXD	| PIN_PULL_DOWN,
+	GPIO146_SSP0_TXD,
+
+	/* MMC0: MicroSD card */
+	GPIO21_MC0_DAT31DIR     | PIN_OUTPUT_HIGH,
+
+	/* MMC2: LAN */
+	GPIO86_SM_ADQ0,
+	GPIO87_SM_ADQ1,
+	GPIO88_SM_ADQ2,
+	GPIO89_SM_ADQ3,
+	GPIO90_SM_ADQ4,
+	GPIO91_SM_ADQ5,
+	GPIO92_SM_ADQ6,
+	GPIO93_SM_ADQ7,
+
+	GPIO94_SM_ADVn,
+	GPIO95_SM_CS0n,
+	GPIO96_SM_OEn,
+	GPIO97_SM_WEn,
+
+	GPIO128_SM_CKO,
+	GPIO130_SM_FBCLK,
+	GPIO131_SM_ADQ8,
+	GPIO132_SM_ADQ9,
+	GPIO133_SM_ADQ10,
+	GPIO134_SM_ADQ11,
+	GPIO135_SM_ADQ12,
+	GPIO136_SM_ADQ13,
+	GPIO137_SM_ADQ14,
+	GPIO138_SM_ADQ15,
+
+	/* RSTn_LAN */
+	GPIO141_GPIO		| PIN_OUTPUT_HIGH,
+};
+
 void __init mop500_pins_init(void)
 {
 	nmk_config_pins(mop500_pins_common,
@@ -235,6 +275,9 @@ void __init mop500_pins_init(void)
 	if (machine_is_hrefv60())
 		nmk_config_pins(mop500_pins_hrefv60,
 				ARRAY_SIZE(mop500_pins_hrefv60));
+	else if (machine_is_snowball())
+		nmk_config_pins(snowball_pins,
+				ARRAY_SIZE(snowball_pins));
 	else
 		nmk_config_pins(mop500_pins_default,
 				ARRAY_SIZE(mop500_pins_default));
-- 
1.7.3.2
