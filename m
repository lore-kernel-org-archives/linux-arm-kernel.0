From: biao.huang@mediatek.com (Biao Huang)
Date: Wed, 13 Apr 2016 15:07:43 +0800
Subject: [RESEND PATCH 1/2] ARM: mediatek: Add MT2701 config options for
 mediatek SoCs.
In-Reply-To: <1460531264-4405-1-git-send-email-biao.huang@mediatek.com>
References: <1460531264-4405-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <1460531264-4405-2-git-send-email-biao.huang@mediatek.com>
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
index 8ced4ad..70e49d5 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -10,6 +10,10 @@ menuconfig ARCH_MEDIATEK
 
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
