From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed, 23 Mar 2011 08:15:41 -0400
Subject: [PATCH 1/2] davinci: mityomapl138: Use correct id for NAND controller
Message-ID: <1300882542-26039-1-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the MityDSP-L138/MityARM-1808 SOMS, the NAND controller id (which needs
to correspond to the chipselect, and is used for controlling the HW ECC
computation) is not correct.  Fix it.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 2aa79c5..e5d554c 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -414,7 +414,7 @@ static struct resource mityomapl138_nandflash_resource[] = {
 
 static struct platform_device mityomapl138_nandflash_device = {
 	.name		= "davinci_nand",
-	.id		= 0,
+	.id		= 1,
 	.dev		= {
 		.platform_data	= &mityomapl138_nandflash_data,
 	},
-- 
1.7.0.4
