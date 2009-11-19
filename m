From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 19 Nov 2009 15:23:04 +0100
Subject: [PATCH 3/7] mx31moboard: support for pin linked for battery presence
	check
In-Reply-To: <1258640588-12705-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1258640588-12705-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1258640588-12705-4-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mx31moboard-marxbot.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 2bfaffb..6b06faf 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -49,6 +49,8 @@ static unsigned int marxbot_pins[] = {
 	MX31_PIN_TXD2__GPIO1_28,
 	/* dsPIC resets */
 	MX31_PIN_STXD5__GPIO1_21, MX31_PIN_SRXD5__GPIO1_22,
+	/*battery detection */
+	MX31_PIN_LCS0__GPIO3_23,
 };
 
 #define SDHC2_CD IOMUX_TO_GPIO(MX31_PIN_ATA_DIOR)
@@ -133,4 +135,9 @@ void __init mx31moboard_marxbot_init(void)
 	dspics_resets_init();
 
 	mxc_register_device(&mxcsdhc_device1, &sdhc2_pdata);
+
+	/* battery present pin */
+	gpio_request(IOMUX_TO_GPIO(MX31_PIN_LCS0), "bat-present");
+	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_LCS0));
+	gpio_export(IOMUX_TO_GPIO(MX31_PIN_LCS0), false);
 }
-- 
1.6.3.3
