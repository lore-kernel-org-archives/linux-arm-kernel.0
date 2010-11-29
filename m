From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 29 Nov 2010 08:58:14 +0100
Subject: [PATCH] ARM: mx25: fix offset for usb host controller
In-Reply-To: <AANLkTik53KX4Ni3Vd7MNpXnxp_c6U=CD_tzJ+7ycEsQ5@mail.gmail.com>
References: <AANLkTik53KX4Ni3Vd7MNpXnxp_c6U=CD_tzJ+7ycEsQ5@mail.gmail.com>
Message-ID: <1291017494-9685-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 2c20b9f (ARM: mx25: dynamically allocate mxc-ehci devices) I
changed the offset to the value specified in the reference manual
intending to test this change on hardware.  This slipped through and now
prooved to be wrong.  So fix it and add a comment about the
documentation being wrong.

Reported-by: Jaume Ribot <jaume@fqingenieria.es>
Cc: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: Shawn Guo <shawn.gsc@gmail.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx25.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 024bebe..087cd7a 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -49,7 +49,12 @@
 #define MX25_SDMA_BASE_ADDR		0x53fd4000
 #define MX25_USB_BASE_ADDR		0x53ff4000
 #define MX25_USB_OTG_BASE_ADDR			(MX25_USB_BASE_ADDR + 0x0000)
-#define MX25_USB_HS_BASE_ADDR			(MX25_USB_BASE_ADDR + 0x0200)
+/*
+ * The reference manual (IMX25RM, Rev. 1, 06/2009) specifies an offset of 0x200
+ * for the host controller.  Early documentation drafts specified 0x400 and
+ * Freescale internal sources confirm only the latter value to work.
+ */
+#define MX25_USB_HS_BASE_ADDR			(MX25_USB_BASE_ADDR + 0x0400)
 #define MX25_CSI_BASE_ADDR		0x53ff8000
 
 #define MX25_IO_P2V(x)			IMX_IO_P2V(x)
-- 
1.7.2.3
