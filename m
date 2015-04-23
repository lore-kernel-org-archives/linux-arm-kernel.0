From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 23 Apr 2015 16:10:00 -0700
Subject: [PATCH v2 7/9] ARM: vfp: Add include guards
In-Reply-To: <1429830602-10988-1-git-send-email-f.fainelli@gmail.com>
References: <1429830602-10988-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1429830602-10988-8-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/vfp.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/vfp.h b/arch/arm/include/asm/vfp.h
index ee5f3084243c..03f9ca3cdfa4 100644
--- a/arch/arm/include/asm/vfp.h
+++ b/arch/arm/include/asm/vfp.h
@@ -5,6 +5,9 @@
  * First, the standard VFP set.
  */
 
+#ifndef __ASM_VFP_H
+#define __ASM_VFP_H
+
 #define FPSID			cr0
 #define FPSCR			cr1
 #define MVFR1			cr6
@@ -87,3 +90,5 @@
 #define VFPOPDESC_UNUSED_BIT	(24)
 #define VFPOPDESC_UNUSED_MASK	(0xFF << VFPOPDESC_UNUSED_BIT)
 #define VFPOPDESC_OPDESC_MASK	(~(VFPOPDESC_LENGTH_MASK | VFPOPDESC_UNUSED_MASK))
+
+#endif /* __ASM_VFP_H */
-- 
2.1.0
