From: linus.luessing@c0d3.blue (=?UTF-8?q?Linus=20L=C3=BCssing?=)
Date: Thu, 28 Sep 2017 22:27:03 +0200
Subject: [PATCH v2] ARM: multi_v7_defconfig: Enable USB3503 driver
Message-ID: <20170928202703.21364-1-linus.luessing@c0d3.blue>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Odroid U3 (Exynos 4412 based) for instance needs this driver,
otherwise its USB hub will not come up.

Also selecting it as built-in to allow booting from USB without
an initrd/initramfs. exynos_defconfig does the same already, too.

Signed-off-by: Linus L?ssing <linus.luessing@c0d3.blue>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 0cacdbf..c2484ef 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -693,6 +693,7 @@ CONFIG_USB_MUSB_HDRC=m
 CONFIG_USB_MUSB_SUNXI=m
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC2=y
+CONFIG_USB_HSIC_USB3503=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
-- 
2.1.4
