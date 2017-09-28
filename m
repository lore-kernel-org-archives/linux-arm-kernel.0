From: linus.luessing@c0d3.blue (=?UTF-8?q?Linus=20L=C3=BCssing?=)
Date: Thu, 28 Sep 2017 04:40:22 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable USB3503 driver
Message-ID: <20170928024022.2071-1-linus.luessing@c0d3.blue>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Odroid U3 (Exynos 4412 based) for instance needs this driver,
otherwise its USB hub will not come up.

exynos_defconfig already has this enabled as built-in, too. So
just doing the same here in multi_v7_defconfig.

Signed-off-by: Linus L?ssing <linus.luessing@c0d3.blue>

---
Thanks to Tobias Jakobi, who indirectly made me aware of why USB
did not work for me.

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
