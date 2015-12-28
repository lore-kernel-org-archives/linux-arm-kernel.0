From: biao.huang@mediatek.com (Biao Huang)
Date: Mon, 28 Dec 2015 15:09:02 +0800
Subject: [PATCH v3 1/5] ARM: mediatek: Add MT2701 config options for mediatek
 SoCs.
In-Reply-To: <1451286546-5920-1-git-send-email-biao.huang@mediatek.com>
References: <1451286546-5920-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <1451286546-5920-2-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Erin Lo <erin.lo@mediatek.com>

The upcoming MTK pinctrl driver have a big pin table for each SoC
and we don't want to bloat the kernel binary if we don't need it.
Add config options so we can build for one SoC only. Add MT2701.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-mediatek/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index aeece17..37dd438 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -9,6 +9,10 @@ menuconfig ARCH_MEDIATEK
 
 if ARCH_MEDIATEK
 
+config MACH_MT2701
+	bool "MediaTek MT2701 SoCs support"
+	default ARCH_MEDIATEK
+
 config MACH_MT6589
 	bool "MediaTek MT6589 SoCs support"
 	default ARCH_MEDIATEK
-- 
1.7.9.5
