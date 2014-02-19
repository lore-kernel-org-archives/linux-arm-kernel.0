From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Feb 2014 23:14:56 +0100
Subject: [PATCH 2/2] ARM: mvebu: Allows to get the SoC ID even without PCI
 enabled
In-Reply-To: <1392848096-17838-1-git-send-email-gregory.clement@free-electrons.com>
References: <1392848096-17838-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1392848096-17838-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address translation of a PCI node don't require anymore the PCI
support in the kernel. This translation is mandatory to be able to
read the SoC ID which is stored in the PCI controller of the mvebu
SoCs.

This patch selects the symbol needed to get only this translation for
all the mvebu platforms.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 5e269d7263ce..df9e7d270810 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -16,6 +16,7 @@ config ARCH_MVEBU
 	select ARCH_REQUIRE_GPIOLIB
 	select MIGHT_HAVE_PCI
 	select PCI_QUIRKS if PCI
+	select OF_ADDRESS_PCI
 
 if ARCH_MVEBU
 
-- 
1.8.1.2
