From: axel.lin@gmail.com (Axel Lin)
Date: Thu, 30 Jun 2011 21:35:03 +0800
Subject: [PATCH] ARM i.MX23/28: platform-mxsfb: Add missing include of
	linux/dma-mapping.h
Message-ID: <1309440903.22791.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix below build error:
  CC      arch/arm/mach-mxs/devices/platform-mxsfb.o
arch/arm/mach-mxs/devices/platform-mxsfb.c: In function 'mx23_add_mxsfb':
arch/arm/mach-mxs/devices/platform-mxsfb.c:27: error: implicit declaration of function 'DMA_BIT_MASK'
make[2]: *** [arch/arm/mach-mxs/devices/platform-mxsfb.o] Error 1
make[1]: *** [arch/arm/mach-mxs/devices] Error 2
make: *** [arch/arm/mach-mxs] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-mxs/devices/platform-mxsfb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/devices/platform-mxsfb.c b/arch/arm/mach-mxs/devices/platform-mxsfb.c
index bf72c9b..5a75b71 100644
--- a/arch/arm/mach-mxs/devices/platform-mxsfb.c
+++ b/arch/arm/mach-mxs/devices/platform-mxsfb.c
@@ -5,6 +5,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
+#include <linux/dma-mapping.h>
 #include <asm/sizes.h>
 #include <mach/mx23.h>
 #include <mach/mx28.h>
-- 
1.7.4.1
