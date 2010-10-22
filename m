From: mreimer@sdgsystems.com (Matt Reimer)
Date: Fri, 22 Oct 2010 17:26:06 -0400
Subject: [PATCH] pxafb: correct the vertical back porch macro
Message-ID: <386708CA-2F13-4D2B-9130-1849ED47BDA1@sdgsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix an off-by-one bug in the LCCR2_BegFrmDel() macro. The vertical back porch
knob LCCR2[BFW] specifies the number of clock periods minus one, but the
macro wasn't doing the subtraction.
---
 arch/arm/mach-pxa/include/mach/regs-lcd.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h b/arch/arm/mach-pxa/include/mach/regs-lcd.h
index f82dcea..5074d18 100644
--- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
+++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
@@ -107,7 +107,7 @@
 #define LCCR2_EndFrmDel(Tln)   ((Tln) << FShft (LCCR2_EFW))
 
 #define LCCR2_BFW      Fld (8, 24)     /* Beginning-of-Frame line clock */
-#define LCCR2_BegFrmDel(Tln)   ((Tln) << FShft (LCCR2_BFW))
+#define LCCR2_BegFrmDel(Tln)   (((Tln) - 1) << FShft (LCCR2_BFW))
 
 #define LCCR3_API      (0xf << 16)     /* AC Bias pin trasitions per interrupt */
 #define LCCR3_API_S    16
-- 
1.7.0.4
