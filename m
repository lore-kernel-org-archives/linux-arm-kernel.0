From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Thu, 25 Feb 2010 18:42:38 +0100
Subject: [PATCH] ARM: SAMSUNG: Fix s3c hsotg driver compilation
Message-ID: <b2e8f9f71002250942y7f61f12tcf3d6770b467985d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

File regs-sys.h was moved from plat to mach.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/usb/gadget/s3c-hsotg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index fec9c09..eda6a91 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -27,10 +27,10 @@
 #include <linux/usb/gadget.h>

 #include <mach/map.h>
+#include <mach/regs-sys.h>

 #include <plat/regs-usb-hsotg-phy.h>
 #include <plat/regs-usb-hsotg.h>
-#include <plat/regs-sys.h>
 #include <plat/udc-hs.h>

 #define DMA_ADDR_INVALID (~((dma_addr_t)0))
-- 
1.7.0
