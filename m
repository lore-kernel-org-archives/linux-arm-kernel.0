From: stigge@antcom.de (Roland Stigge)
Date: Mon, 12 Mar 2012 22:54:49 +0100
Subject: [PATCH v8 1/4] USB: OHCI-HCD: Rename ohci-pnx4008 to ohci-nxp
In-Reply-To: <1331589292-18986-1-git-send-email-stigge@antcom.de>
References: <1331589292-18986-1-git-send-email-stigge@antcom.de>
Message-ID: <1331589292-18986-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since this driver is compatible with several NXP devices, the driver is renamed
accordingly. Please combine with the following patch which also changes the
respective symbol names.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 drivers/usb/host/ohci-hcd.c                     |    2 +-
 drivers/usb/host/{ohci-pnx4008.c => ohci-nxp.c} |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename drivers/usb/host/{ohci-pnx4008.c => ohci-nxp.c} (100%)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 34b9edd..713c66c 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1051,7 +1051,7 @@ MODULE_LICENSE ("GPL");
 #endif
 
 #ifdef CONFIG_ARCH_PNX4008
-#include "ohci-pnx4008.c"
+#include "ohci-nxp.c"
 #define PLATFORM_DRIVER		usb_hcd_pnx4008_driver
 #endif
 
diff --git a/drivers/usb/host/ohci-pnx4008.c b/drivers/usb/host/ohci-nxp.c
similarity index 100%
rename from drivers/usb/host/ohci-pnx4008.c
rename to drivers/usb/host/ohci-nxp.c
-- 
1.7.9
