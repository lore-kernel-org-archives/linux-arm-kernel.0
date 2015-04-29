From: ao2@ao2.it (Antonio Ospite)
Date: Wed, 29 Apr 2015 11:13:59 +0200
Subject: [PATCHv2] ARM: lib/lib1funcs.S: fix typo s/substractions/subtractions/
In-Reply-To: <CAKv+Gu-7SRFaPbXQynfu6OiZCnS5xA2qMkRYWmgf0+T9SWdDRQ@mail.gmail.com>
References: <CAKv+Gu-7SRFaPbXQynfu6OiZCnS5xA2qMkRYWmgf0+T9SWdDRQ@mail.gmail.com>
Message-ID: <1430298839-23658-1-git-send-email-ao2@ao2.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While at it also fix some other typos in the affected lines:
  s/reminder/remainder/
  s/comparison/comparisons/

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---

Changes since v1:
  - fix the other typos as suggested by Ard.

Ciao,
   Antonio

 arch/arm/lib/lib1funcs.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/lib1funcs.S b/arch/arm/lib/lib1funcs.S
index 947567f..055c00f 100644
--- a/arch/arm/lib/lib1funcs.S
+++ b/arch/arm/lib/lib1funcs.S
@@ -167,7 +167,7 @@ Boston, MA 02111-1307, USA.  */
 
 #endif
 
-	@ Perform all needed substractions to keep only the reminder.
+	@ Perform all needed subtractions to keep only the remainder.
 	@ Do comparisons in batch of 4 first.
 	subs	\order, \order, #3		@ yes, 3 is intended here
 	blt	2f
@@ -189,7 +189,7 @@ Boston, MA 02111-1307, USA.  */
 	teqne	\dividend, #0
 	beq	5f
 
-	@ Either 1, 2 or 3 comparison/substractions are left.
+	@ Either 1, 2 or 3 comparisons/subtractions are left.
 2:	cmn	\order, #2
 	blt	4f
 	beq	3f
-- 
2.1.4
