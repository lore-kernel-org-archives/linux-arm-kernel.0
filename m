From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 25 Jun 2012 14:56:19 +0800
Subject: [PATCH v7 02/14] usb: chipidea: drop useless arch-check
In-Reply-To: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1340607391-16380-3-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

msm glue layer compiles on all arches just
fine. Let's drop the unnecessary ARCH check
so we have easier compile tests.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/usb/chipidea/Makefile |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index cc34937..b69900a 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -5,10 +5,12 @@ ci_hdrc-$(CONFIG_USB_CHIPIDEA_UDC)	+= udc.o
 ci_hdrc-$(CONFIG_USB_CHIPIDEA_HOST)	+= host.o
 ci_hdrc-$(CONFIG_USB_CHIPIDEA_DEBUG)	+= debug.o
 
+# Glue/Bridge layers go here
+
+obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_msm.o
+
+# PCI doesn't provide stubs, need to check
 ifneq ($(CONFIG_PCI),)
 	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_pci.o
 endif
 
-ifneq ($(CONFIG_ARCH_MSM),)
-	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_msm.o
-endif
-- 
1.7.9.5
