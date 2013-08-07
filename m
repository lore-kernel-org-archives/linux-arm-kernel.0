From: tkazmierczak@EUROFUNK.COM (KAZMIERCZAK Tobias)
Date: Wed, 7 Aug 2013 09:17:07 +0200
Subject: [PATCH] Fix incorrect define for OMAP padmux
Message-ID: <9FA67543B55C1040AED85F8B8154F91C03FFBCB8@mailsrv.eurofunk.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for the macro OMAP3_MUX() to work, _OFFSET has to be added

Signed-off-by: Tobias Kazmierczak <tkazmierczak@eurofunk.com>
---
 arch/arm/mach-omap2/mux34xx.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff --git a/arch/arm/mach-omap2/mux34xx.h
b/arch/arm/mach-omap2/mux34xx.h
index 3f26d29..82a3feb 100644
--- a/arch/arm/mach-omap2/mux34xx.h
+++ b/arch/arm/mach-omap2/mux34xx.h
@@ -393,10 +393,10 @@
 #define OMAP3_CONTROL_PADCONF_SAD2D_SWAKEUP_OFFSET             0xa1c
 #define OMAP3_CONTROL_PADCONF_JTAG_RTCK_OFFSET                 0xa1e
 #define OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET                  0xa20
-#define OMAP3_CONTROL_PADCONF_GPIO_127                         0xa24
-#define OMAP3_CONTROL_PADCONF_GPIO_126                         0xa26
-#define OMAP3_CONTROL_PADCONF_GPIO_128                         0xa28
-#define OMAP3_CONTROL_PADCONF_GPIO_129                         0xa2a
+#define OMAP3_CONTROL_PADCONF_GPIO_127_OFFSET                  0xa24
+#define OMAP3_CONTROL_PADCONF_GPIO_126_OFFSET                  0xa26
+#define OMAP3_CONTROL_PADCONF_GPIO_128_OFFSET                  0xa28
+#define OMAP3_CONTROL_PADCONF_GPIO_129_OFFSET                  0xa2a
 
 #define OMAP3_CONTROL_PADCONF_MUX_SIZE                         \
-               (OMAP3_CONTROL_PADCONF_GPIO_129 + 0x2)
+               (OMAP3_CONTROL_PADCONF_GPIO_129_OFFSET + 0x2)
