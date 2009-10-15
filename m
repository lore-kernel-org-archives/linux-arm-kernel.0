From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 15 Oct 2009 11:42:57 +0200
Subject: [PATCH 3/6] mx31moboard: support for pin linked for battery presence
	check
In-Reply-To: <1255599780-12948-3-git-send-email-valentin.longchamp@epfl.ch>
References: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-2-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-3-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1255599780-12948-4-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mx31moboard-marxbot.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 2bfaffb..49d47ab 100644
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
@@ -133,4 +135,11 @@ void __init mx31moboard_marxbot_init(void)
 	dspics_resets_init();
 
 	mxc_register_device(&mxcsdhc_device1, &sdhc2_pdata);
+
+	marxbot_cam_init();
+
+	/* battery present pin */
+	gpio_request(IOMUX_TO_GPIO(MX31_PIN_LCS0), "bat-present");
+	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_LCS0));
+	gpio_export(IOMUX_TO_GPIO(MX31_PIN_LCS0), false);
 }
-- 
1.6.0.4
