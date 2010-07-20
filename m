From: qy03fugy@stud.informatik.uni-erlangen.de (Christian Dietrich)
Date: Tue, 20 Jul 2010 09:08:01 +0200
Subject: [PATCH] usb/host: Remove dead CONFIG_ARCH_KARO
In-Reply-To: <4C3E24DE.7050208@bluewatersys.com> (Ryan Mallon's message of
	"Thu, 15 Jul 2010 08:58:06 +1200")
References: <cover.1279104996.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<9df7166bb950e7fbc12d1be9f2b9f9cbb9961187.1279104996.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<4C3E24DE.7050208@bluewatersys.com>
Message-ID: <86zkxmk4vi.fsf_-_@peer.zerties.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


CONFIG_ARCH_KARO doesn't exist in Kconfig and is never defined anywhere
else, therefore removing all references for it from the source code.

Signed-off-by: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
---
 drivers/usb/host/isp1362.h |   24 +-----------------------
 1 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/host/isp1362.h b/drivers/usb/host/isp1362.h
index d995351..0f97820 100644
--- a/drivers/usb/host/isp1362.h
+++ b/drivers/usb/host/isp1362.h
@@ -8,29 +8,7 @@
 /*
  * Platform specific compile time options
  */
-#if defined(CONFIG_ARCH_KARO)
-#include <asm/arch/hardware.h>
-#include <asm/arch/pxa-regs.h>
-#include <asm/arch/karo.h>
-
-#define USE_32BIT              1
-
-
-/* These options are mutually eclusive */
-#define USE_PLATFORM_DELAY    1
-#define USE_NDELAY             0
-/*
- * MAX_ROOT_PORTS: Number of downstream ports
- *
- * The chip has two USB ports, one of which can be configured as
- * an USB device port, so the value of this constant is implementation
- * specific.
- */
-#define MAX_ROOT_PORTS         2
-#define DUMMY_DELAY_ACCESS do {} while (0)
-
-/* insert platform specific definitions for other machines here */
-#elif defined(CONFIG_BLACKFIN)
+#if defined(CONFIG_BLACKFIN)
 
 #include <linux/io.h>
 #define USE_32BIT              0
-- 
1.7.0.4
