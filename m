From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Sep 2010 18:50:59 -0700
Subject: [PATCH 06/11] omap: usb: fix build warning
In-Reply-To: <20100924014938.10325.35279.stgit@baageli.muru.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
Message-ID: <20100924015059.10325.14660.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anand Gadiyar <gadiyar@ti.com>

Fix this and similar build warnings when building with
omap_4430sdp_defconfig.

 CC      arch/arm/mach-omap2/board-4430sdp.o
In file included from arch/arm/mach-omap2/board-4430sdp.c:36:
arch/arm/plat-omap/include/plat/usb.h:109: warning: return type defaults to 'int'

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/usb.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 2a9427c..6674562 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -105,7 +105,7 @@ static inline void omap1_usb_init(struct omap_usb_config *pdata)
 #if defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_ARCH_OMAP_OTG_MODULE)
 void omap2_usbfs_init(struct omap_usb_config *pdata);
 #else
-static inline omap2_usbfs_init(struct omap_usb_config *pdata)
+static inline void omap2_usbfs_init(struct omap_usb_config *pdata)
 {
 }
 #endif
