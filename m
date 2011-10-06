From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu,  6 Oct 2011 17:39:47 +0200
Subject: [PATCH 1/3] sam9g20ek/9m10g45ek/stam9g20: unbreak build after 'use
	-EINVAL for invalid gpio'
Message-ID: <1317915587-27474-1-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 36706ab70b26 (ARM: at91/boards: use -EINVAL for invalid gpio)
broke the build as it used ';' rather than ',' in structure initializers.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/mach-at91/board-sam9g20ek.c    |    2 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c |    2 +-
 arch/arm/mach-at91/board-stamp9g20.c    |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 1c6dfbb..27943c2 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -212,7 +212,7 @@ static struct mci_platform_data __initdata ek_mmc_data = {
 	.slot[1] = {
 		.bus_width	= 4,
 		.detect_pin	= AT91_PIN_PC9,
-		.wp_pin		= -1;
+		.wp_pin		= -1,
 	},
 
 };
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 3d68ead..008088a 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -100,7 +100,7 @@ static struct mci_platform_data __initdata mci0_data = {
 	.slot[0] = {
 		.bus_width	= 4,
 		.detect_pin	= AT91_PIN_PD10,
-		.wp_pin		= -1;
+		.wp_pin		= -1,
 	},
 };
 
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 3c0cc86..cb4a840 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -123,8 +123,8 @@ static void __init add_device_nand(void)
 static struct mci_platform_data __initdata mmc_data = {
 	.slot[0] = {
 		.bus_width	= 4,
-		.detect_pin	= -1;
-		.wp_pin		= -1;
+		.detect_pin	= -1,
+		.wp_pin		= -1,
 	},
 };
 #else
-- 
1.7.6.3
