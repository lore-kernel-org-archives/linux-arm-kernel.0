From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 27 Jun 2013 12:03:25 +0800
Subject: [PATCH] include/asm-generic/pci.h: include generic "pci-dma-compat.h"
Message-ID: <51CBB98D.3040304@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If an architecture need "generic pci.h", it also need generic "pci-dma-
compat.h",  so recommend to include it in asm-generic directly.

And now, for arm64 and m32r, may cause compiling error about it.

The related error (with allmodconfig):

  drivers/media/usb/b2c2/flexcop-usb.c: In function ?flexcop_usb_transfer_exit?:
  drivers/media/usb/b2c2/flexcop-usb.c:393:3: error: implicit declaration of function ?pci_free_consistent? [-Werror=implicit-function-declaration]
  drivers/media/usb/b2c2/flexcop-usb.c: In function ?flexcop_usb_transfer_init?:
  drivers/media/usb/b2c2/flexcop-usb.c:410:2: error: implicit declaration of function ?pci_alloc_consistent? [-Werror=implicit-function-declaration]
  drivers/media/usb/b2c2/flexcop-usb.c:410:21: warning: assignment makes pointer from integer without a cast [enabled by default]
  cc1: some warnings being treated as errors


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 include/asm-generic/pci.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
index e80a049..64e2a15 100644
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_GENERIC_PCI_H
 #define _ASM_GENERIC_PCI_H
 
+#include <asm-generic/pci-dma-compat.h>
+
 static inline struct resource *
 pcibios_select_root(struct pci_dev *pdev, struct resource *res)
 {
-- 
1.7.7.6
