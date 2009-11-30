From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Nov 2009 13:31:29 +0100
Subject: [PATCH] i.MX27 audmux: Fix register offsets
Message-ID: <mailman.56.1259584457.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PPCR registers start at 0x10, not 0xc. Fix this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/audmux.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/audmux.h b/arch/arm/plat-mxc/include/mach/audmux.h
index 5cd6466..dcc12d4 100644
--- a/arch/arm/plat-mxc/include/mach/audmux.h
+++ b/arch/arm/plat-mxc/include/mach/audmux.h
@@ -4,9 +4,9 @@
 #define MX27_AUDMUX_HPCR1_SSI0		0
 #define MX27_AUDMUX_HPCR2_SSI1		1
 #define MX27_AUDMUX_HPCR3_SSI_PINS_4	2
-#define MX27_AUDMUX_PPCR1_SSI_PINS_1	3
-#define MX27_AUDMUX_PPCR2_SSI_PINS_2	4
-#define MX27_AUDMUX_PPCR3_SSI_PINS_3	5
+#define MX27_AUDMUX_PPCR1_SSI_PINS_1	4
+#define MX27_AUDMUX_PPCR2_SSI_PINS_2	5
+#define MX27_AUDMUX_PPCR3_SSI_PINS_3	6
 
 #define MX31_AUDMUX_PORT1_SSI0		0
 #define MX31_AUDMUX_PORT2_SSI1		1
-- 
1.6.5.2

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
