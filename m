From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Thu, 20 Nov 2014 13:53:05 +0200
Subject: [PATCH] ARM: imx: set system_rev value
Message-ID: <1416484385-22501-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set system_rev value to chip silicon version USB_ANALOG_DIGPROG.

  root at mx6q:~# cat /proc/cpuinfo | grep Revision
  Revision	: 630002

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 arch/arm/mach-imx/anatop.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 8259a62..505100f 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <asm/system_info.h>
 #include "common.h"
 #include "hardware.h"
 
@@ -123,6 +124,7 @@ void __init imx_init_revision_from_anatop(void)
 
 	mxc_set_cpu_type(digprog >> 16 & 0xff);
 	imx_set_soc_revision(revision);
+	system_rev = digprog & 0xffffff;
 }
 
 void __init imx_anatop_init(void)
-- 
1.7.10.4
