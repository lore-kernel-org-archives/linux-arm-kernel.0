From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 25 Aug 2011 12:24:28 -0300
Subject: [PATCH] ARM: mx51: Fix chip revision detection
Message-ID: <1314285868-10782-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ca5f9dd9 (ARM: mx5: use generic function for displaying silicon revision)
incorrectly changed the check value for MX51 TO3.0.

Fix this so that MX51 TO3.0 can be correctly reported.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index df46967..5c53282 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -31,7 +31,7 @@ static int get_mx51_srev(void)
 	switch (rev) {
 	case 0x0:
 		return IMX_CHIP_REVISION_2_0;
-	case 0x2:
+	case 0x10:
 		return IMX_CHIP_REVISION_3_0;
 	default:
 		return IMX_CHIP_REVISION_UNKNOWN;
-- 
1.6.0.4
