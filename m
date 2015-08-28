From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Aug 2015 12:19:42 -0700
Subject: [PATCH] ARM: omap2plus_defconfig: Enable MUSB DMA support
Message-ID: <1440789582-25392-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With recent MUSB changes we can now build in support for multiple
DMA implementations. So let's enable DMA by default to make life
easier for distro use.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 789fa5a8..1d5f80f 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -350,6 +350,8 @@ CONFIG_USB_MUSB_HDRC=m
 CONFIG_USB_MUSB_OMAP2PLUS=m
 CONFIG_USB_MUSB_AM35X=m
 CONFIG_USB_MUSB_DSPS=m
+CONFIG_USB_INVENTRA_DMA=y
+CONFIG_USB_TI_CPPI41_DMA=y
 CONFIG_USB_DWC3=m
 CONFIG_USB_TEST=m
 CONFIG_AM335X_PHY_USB=y
-- 
2.1.4
