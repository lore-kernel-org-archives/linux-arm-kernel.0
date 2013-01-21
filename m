From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 21 Jan 2013 05:07:25 -0500
Subject: [V4 PATCH 07/26] usb: gadget: mv_udc: make mv_udc depends on ARCH_MMP
 or ARCH_PXA
In-Reply-To: <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
References: <xiechao.mail@gmail.com>
 <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1358762864-9249-8-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only ARCH_PXA and ARCH_MMP will use mv_udc.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/gadget/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 14625fd..53943f7 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -319,6 +319,7 @@ config USB_S3C_HSUDC
 
 config USB_MV_UDC
 	tristate "Marvell USB2.0 Device Controller"
+	depends on ARCH_PXA || ARCH_MMP
 	help
 	  Marvell Socs (including PXA and MMP series) include a high speed
 	  USB2.0 OTG controller, which can be configured as high speed or
-- 
1.7.4.1
