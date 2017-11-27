From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 18:38:51 +0000
Subject: [PATCH 4/6] ARM: sa1111: remove some redundant definitions
In-Reply-To: <20171127183811.GM31757@n2100.armlinux.org.uk>
References: <20171127183811.GM31757@n2100.armlinux.org.uk>
Message-ID: <E1eJOIt-0006of-IA@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SA1111_VBASE, SA1111_p2v, SA1111_v2p, _SA1111, SA1111_ADDR_WIDTH,
SA1111_ADDR_MASK, and SA1111_DMA_ADDR are not used anywhere in the
kernel, so remove these redundant definitions.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/hardware/sa1111.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 8a7ccebd109d..709980647dd1 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -16,30 +16,6 @@
 #include <mach/bitfield.h>
 
 /*
- * The SA1111 is always located at virtual 0xf4000000, and is always
- * "native" endian.
- */
-
-#define SA1111_VBASE		0xf4000000
-
-/* Don't use these! */
-#define SA1111_p2v( x )         ((x) - SA1111_BASE + SA1111_VBASE)
-#define SA1111_v2p( x )         ((x) - SA1111_VBASE + SA1111_BASE)
-
-#ifndef __ASSEMBLY__
-#define _SA1111(x)	((x) + sa1111->resource.start)
-#endif
-
-/*
- * 26 bits of the SA-1110 address bus are available to the SA-1111.
- * Use these when feeding target addresses to the DMA engines.
- */
-
-#define SA1111_ADDR_WIDTH	(26)
-#define SA1111_ADDR_MASK	((1<<SA1111_ADDR_WIDTH)-1)
-#define SA1111_DMA_ADDR(x)	((x)&SA1111_ADDR_MASK)
-
-/*
  * Don't ask the (SAC) DMA engines to move less than this amount.
  */
 
-- 
2.7.4
