From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 16 Feb 2016 19:14:52 +0100
Subject: [PATCH v4 02/12] irqchip: armada-370-xp: do not enable it by default
 when ARCH_MVEBU is selected
In-Reply-To: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1455646502-23834-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq-armada-370-xp driver can only be built for ARM 32 bits. The mvebu
family had grown with a new ARM64 SoC which will also select the
ARCH_MEVBU configuration. Since "ARM: mvebu: use the ARMADA_370_XP_IRQ
option", the ARM32 mvebu SoC directly select this new option. Selecting
it by default when ARCH_MEVBU is selected is no more needed.

This patch removes this dependency, thanks to this, a kernel for ARM64
mvebu SoC can be built without error due this driver.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/irqchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e2cab879d641..b6e7e86a57e1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -62,7 +62,6 @@ config ARM_VIC_NR
 
 config ARMADA_370_XP_IRQ
 	bool
-	default y if ARCH_MVEBU
 	select GENERIC_IRQ_CHIP
 
 config ATMEL_AIC_IRQ
-- 
2.5.0
