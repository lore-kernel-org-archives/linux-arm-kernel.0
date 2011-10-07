From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  7 Oct 2011 12:31:36 +0200
Subject: [PATCH] sam9g20ek/9m10g45ek/stam9g20: unbreak build after 'use
	-EINVAL for invalid gpio'
In-Reply-To: <1317915587-27474-1-git-send-email-jacmet@sunsite.dk>
References: <1317915587-27474-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <1317983496-6102-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Korsgaard <jacmet@sunsite.dk>

Commit 36706ab70b26 (ARM: at91/boards: use -EINVAL for invalid gpio)
broke the build as it used ';' rather than ',' in structure initializers.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
[nicolas.ferre at atmel.com: change also -1 to -EINVAL for coherency]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-sam9g20ek.c    |    4 ++--
 arch/arm/mach-at91/board-sam9m10g45ek.c |    2 +-
 arch/arm/mach-at91/board-stamp9g20.c    |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index b3ec5e6..52d122d 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -217,7 +217,7 @@ static struct mci_platform_data __initdata ek_mmc_data = {
 	.slot[1] = {
 		.bus_width	= 4,
 		.detect_pin	= AT91_PIN_PC9,
-		.wp_pin		= -1;
+		.wp_pin		= -EINVAL,
 	},
 
 };
@@ -237,7 +237,7 @@ static void __init ek_add_device_mmc(void)
 	if (ek_have_2mmc()) {
 		ek_mmc_data.slot[0].bus_width = 4;
 		ek_mmc_data.slot[0].detect_pin = AT91_PIN_PC2;
-		ek_mmc_data.slot[0].wp_pin = -1;
+		ek_mmc_data.slot[0].wp_pin = -EINVAL;
 	}
 	at91_add_device_mci(0, &ek_mmc_data);
 #else
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 3c36f9f..8e7d8ad 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -100,7 +100,7 @@ static struct mci_platform_data __initdata mci0_data = {
 	.slot[0] = {
 		.bus_width	= 4,
 		.detect_pin	= AT91_PIN_PD10,
-		.wp_pin		= -1;
+		.wp_pin		= -EINVAL,
 	},
 };
 
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 3c0cc86..0bd51ee 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -123,8 +123,8 @@ static void __init add_device_nand(void)
 static struct mci_platform_data __initdata mmc_data = {
 	.slot[0] = {
 		.bus_width	= 4,
-		.detect_pin	= -1;
-		.wp_pin		= -1;
+		.detect_pin	= -EINVAL,
+		.wp_pin		= -EINVAL,
 	},
 };
 #else
-- 
1.7.3
