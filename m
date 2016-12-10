From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 10 Dec 2016 15:47:35 +0200
Subject: [RFC 4/7] ARM: s3c64xx: Annotate external clock frequencies
 __ro_after_init
In-Reply-To: <1481377658-22603-1-git-send-email-krzk@kernel.org>
References: <1481377658-22603-1-git-send-email-krzk@kernel.org>
Message-ID: <1481377658-22603-4-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xtal_f and xusbxti_f static variables are modified only through
__init accessors (like s3c64xx_set_xtal_freq()).  Later these variables
are used only in read-only way so we can mark them __ro_after_init to
increase code safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Looks safe, but not tested.
---
 arch/arm/mach-s3c64xx/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 7c66ce1a6bb6..9843eb4dd04e 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -56,7 +56,8 @@
 #include "watchdog-reset.h"
 
 /* External clock frequency */
-static unsigned long xtal_f = 12000000, xusbxti_f = 48000000;
+static unsigned long xtal_f __ro_after_init = 12000000;
+static unsigned long xusbxti_f __ro_after_init = 48000000;
 
 void __init s3c64xx_set_xtal_freq(unsigned long freq)
 {
-- 
2.7.4
