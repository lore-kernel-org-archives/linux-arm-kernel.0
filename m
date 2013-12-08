From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon,  9 Dec 2013 02:53:43 +0400
Subject: [PATCH 3/9] ARM: fix ohci-pxa27x build error with OF enabled
In-Reply-To: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
Message-ID: <1386543229-1542-4-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--->8---
$ make
  CC [M]  drivers/usb/host/ohci-pxa27x.o
drivers/usb/host/ohci-pxa27x.c: In function ?ohci_pxa_of_init?:
drivers/usb/host/ohci-pxa27x.c:310:2: error: implicit declaration of function ?dma_coerce_mask_and_coherent? [-Werror=implicit-function-declaration]
drivers/usb/host/ohci-pxa27x.c:310:2: error: implicit declaration of function ?DMA_BIT_MASK? [-Werror=implicit-function-declaration]
--->8---

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Russell King - ARM Linux <linux@arm.linux.org.uk>

 # Changes to be committed:
---
 drivers/usb/host/ohci-pxa27x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index e89ac4d..97983fd 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/dma-mapping.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
-- 
1.8.4.3
