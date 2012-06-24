From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 24 Jun 2012 17:57:10 +0100
Subject: imx27_visstrim_m10: spot the mistake
Message-ID: <20120624165710.GA20378@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 435ca24116bc5365a10fa0be1bf1c1e4c5680157
Author: Javier Martin <javier.martin@vista-silicon.com>
Date:   Tue Apr 10 11:26:59 2012 +0200

    ARM i.MX: Visstrim_M10: Add board version detection.
    
    Visstrim_M10 boards have 3 gpios to detect the
    expansion board version attached and other 3 to
    detect the motherboard revision.
    
    Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index f7b074f..748ba2e 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -38,6 +38,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/system.h>
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>

...

commit 9f97da78bf018206fb623cd351d454af2f105fe0
Author: David Howells <dhowells@redhat.com>
Date:   Wed Mar 28 18:30:01 2012 +0100

    Disintegrate asm/system.h for ARM
    
    Disintegrate asm/system.h for ARM.
    
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Russell King <linux@arm.linux.org.uk>
    cc: linux-arm-kernel at lists.infradead.org

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 774c41e..74542c5 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
+/* FILE TO BE DELETED. DO NOT ADD STUFF HERE! */
+#include <asm/barrier.h>
+#include <asm/compiler.h>
+#include <asm/cmpxchg.h>
+#include <asm/exec.h>
+#include <asm/switch_to.h>
+#include <asm/system_info.h>
+#include <asm/system_misc.h>

What's wrong with the above commit to mach-imx27_visstrim_m10.c ?
