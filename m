From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon,  9 Jun 2014 17:52:45 -0300
Subject: [PATCH] ARM: mvebu: Fix broken SoC ID detection
Message-ID: <1402347165-19988-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the mvebu boards need to detect the SoC revision in order to apply
some quirks needed to workaround issues found on I2C and thermal controllers
present only in very early SoC.

This detection requires PCI address translation to work, so we need to
explicitly select OF_ADDRESS_PCI.

This can be considered a partial revert of the following commit, that
wrongly removed the option selection:

commit 55400f3a1f89e39761f45c19f6e4235a329c400b
Author: Rob Herring <robh@kernel.org>
Date:   Tue Apr 22 14:15:52 2014 -0500

    ARM: mvebu: clean-up unneeded kconfig selects

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 6090b9e..61ac80a 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -10,6 +10,7 @@ config ARCH_MVEBU
 	select ZONE_DMA if ARM_LPAE
 	select ARCH_REQUIRE_GPIOLIB
 	select PCI_QUIRKS if PCI
+	select OF_ADDRESS_PCI
 
 if ARCH_MVEBU
 
-- 
1.9.1
