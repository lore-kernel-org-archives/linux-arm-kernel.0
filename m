From: ao2@ao2.it (Antonio Ospite)
Date: Wed, 27 Jan 2016 14:51:10 +0100
Subject: [PATCH] ARM: lib/lib1funcs.S: fix typo s/substractions/subtractions/
Message-ID: <1453902670-32294-1-git-send-email-ao2@ao2.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While at it also fix some other typos in the affected lines:
  s/reminder/remainder/
  s/comparison/comparisons/

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/lib/lib1funcs.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/lib1funcs.S b/arch/arm/lib/lib1funcs.S
index 9397b2e..8e89c20 100644
--- a/arch/arm/lib/lib1funcs.S
+++ b/arch/arm/lib/lib1funcs.S
@@ -167,7 +167,7 @@ Boston, MA 02111-1307, USA.  */
 
 #endif
 
-	@ Perform all needed subtractions to keep only the reminder.
+	@ Perform all needed subtractions to keep only the remainder.
 	@ Do comparisons in batch of 4 first.
 	subs	\order, \order, #3		@ yes, 3 is intended here
 	blt	2f
@@ -189,7 +189,7 @@ Boston, MA 02111-1307, USA.  */
 	teqne	\dividend, #0
 	beq	5f
 
-	@ Either 1, 2 or 3 comparison/subtractions are left.
+	@ Either 1, 2 or 3 comparisons/subtractions are left.
 2:	cmn	\order, #2
 	blt	4f
 	beq	3f
-- 
2.7.0
