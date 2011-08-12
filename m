From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 12 Aug 2011 15:07:59 +0800
Subject: [PATCH] mtd: mxc_nand: Add mx53 NFC driver support
Message-ID: <1313132879-10531-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has already been tested with Samsung NAND: K9LAG08U0M
on MX53EVK board, ubi/ubifs has already been tested OK too.

Signed-off-by: Jason Liu <jason.hui@linaro.org>
---
 drivers/mtd/nand/mxc_nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 90df34c..a3f1b50 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -41,7 +41,7 @@
 
 #define nfc_is_v21()		(cpu_is_mx25() || cpu_is_mx35())
 #define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27() || cpu_is_mx21())
-#define nfc_is_v3_2()		cpu_is_mx51()
+#define nfc_is_v3_2()		(cpu_is_mx51() || cpu_is_mx53())
 #define nfc_is_v3()		nfc_is_v3_2()
 
 /* Addresses for NFC registers */
-- 
1.7.4.1
