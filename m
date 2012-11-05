From: javier.martin@vista-silicon.com (Javier Martin)
Date: Mon,  5 Nov 2012 16:59:44 +0100
Subject: [PATCH 1/2] ARM: i.MX27: Add platform support for IRAM.
Message-ID: <1352131185-12079-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for IRAM to i.MX27 non-DT platforms using
iram_init() function.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/mm-imx27.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index e7e24af..fd2416d 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -27,6 +27,7 @@
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
 #include <mach/iomux-v1.h>
+#include <mach/iram.h>
 
 /* MX27 memory map definition */
 static struct map_desc imx27_io_desc[] __initdata = {
@@ -94,4 +95,6 @@ void __init imx27_soc_init(void)
 	/* imx27 has the imx21 type audmux */
 	platform_device_register_simple("imx21-audmux", 0, imx27_audmux_res,
 					ARRAY_SIZE(imx27_audmux_res));
+	/* imx27 has an iram of 46080 bytes size */
+	iram_init(MX27_IRAM_BASE_ADDR, 46080);
 }
-- 
1.7.9.5
