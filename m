From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 2 Jul 2014 11:47:47 +0300
Subject: [PATCH 13/13] ARM: OMAP2+: clock/interface: remove some headers from
 clkt_iclk.c file
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Message-ID: <1404290867-6768-14-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead, copy the used constants from the header file to the source file.
This allows the code to be migrated under drivers folder where we don't
have access to the OMAP specific header files.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt_iclk.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index 333f0a6..55eb579 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/arch/arm/mach-omap2/clkt_iclk.c
@@ -14,11 +14,11 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 
-
 #include "clock.h"
-#include "clock2xxx.h"
-#include "cm2xxx_3xxx.h"
-#include "cm-regbits-24xx.h"
+
+/* Register offsets */
+#define CM_AUTOIDLE			0x30
+#define CM_ICLKEN			0x10
 
 /* Private functions */
 
-- 
1.7.9.5
