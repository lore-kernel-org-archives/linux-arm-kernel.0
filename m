From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 21 May 2013 12:27:25 +0400
Subject: [PATCH] ARM: iomux-mx51: Always define PUE for pins used as GPIO
Message-ID: <1369124845-19244-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a PUE bit for pins which used as GPIO. This allow
to use the GPIOs correctly as inputs when source is open-drain with
external pullup resistor (IRQ open-drain outputs for example).

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/iomux-mx51.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/iomux-mx51.h b/arch/arm/mach-imx/iomux-mx51.h
index 75bbcc4..7dc187c 100644
--- a/arch/arm/mach-imx/iomux-mx51.h
+++ b/arch/arm/mach-imx/iomux-mx51.h
@@ -34,7 +34,8 @@
 #define MX51_SDHCI_PAD_CTRL	(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | \
 				PAD_CTL_PUS_47K_UP | PAD_CTL_PUE | \
 				PAD_CTL_SRE_FAST | PAD_CTL_DVS)
-#define MX51_GPIO_PAD_CTRL	(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | PAD_CTL_SRE_FAST)
+#define MX51_GPIO_PAD_CTRL	(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | \
+				PAD_CTL_PUE | PAD_CTL_SRE_FAST)
 
 #define MX51_PAD_CTRL_2		(PAD_CTL_PKE | PAD_CTL_HYS)
 #define MX51_PAD_CTRL_3		(PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
-- 
1.8.1.5
