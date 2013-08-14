From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 Aug 2013 20:49:35 -0500
Subject: [PATCH] ARM: highbank: fix debug uart virtual address for LPAE
Message-ID: <1376444975-28307-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Section entries are 2MB on LPAE, so the DEBUG_LL virtual address must
have the same offset in the 2MB section as the physical address. This
fixes async external aborts when DEBUG_LL is enabled on Midway.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/debug/highbank.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/debug/highbank.S b/arch/arm/include/debug/highbank.S
index 8cad432..3204ff3 100644
--- a/arch/arm/include/debug/highbank.S
+++ b/arch/arm/include/debug/highbank.S
@@ -10,7 +10,7 @@
  */
 
 		.macro	addruart,rp,rv,tmp
-		ldr	\rv, =0xfee36000
+		ldr	\rv, =0xfef36000
 		ldr	\rp, =0xfff36000
 		.endm
 
-- 
1.8.1.2
