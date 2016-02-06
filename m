From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Feb 2016 23:53:49 +0800
Subject: [PATCH 6/6] ARM: multi_v7_defconfig: Enable MUSB HDRC driver with
 Allwinner glue
In-Reply-To: <1454774029-10469-1-git-send-email-wens@csie.org>
References: <1454774029-10469-1-git-send-email-wens@csie.org>
Message-ID: <1454774029-10469-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner SoCs typically have a Mentor Graphics Inventra MUSB high speed
dual role controller for USB OTG.

Now that the issue with MUSB and USB gadget registration order has been
resolved, we can enable this driver in dual role mode.

This patch only enables the driver core and Allwinner platform support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 03703b7ea530..b500f18d0c35 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -592,6 +592,8 @@ CONFIG_USB_OHCI_EXYNOS=m
 CONFIG_USB_R8A66597_HCD=m
 CONFIG_USB_RENESAS_USBHS=m
 CONFIG_USB_STORAGE=y
+CONFIG_USB_MUSB_HDRC=m
+CONFIG_USB_MUSB_SUNXI=m
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC2=m
 CONFIG_USB_CHIPIDEA=y
-- 
2.7.0
