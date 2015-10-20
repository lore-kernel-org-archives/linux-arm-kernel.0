From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 20 Oct 2015 16:50:05 -0500
Subject: [PATCH 1/5] ARM: Keystone: Enable PINCTRL for Keystone ARCH
Message-ID: <1445377809-12516-1-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Franklin Cooper <fcooper@ti.com>

Unlike other Keystone 2 devices, newer Keystone 2 SOCs may utilize
pinmuxing which requires PINCTRL to be enabled. Therefore, enable
PINCTRL for all Keystone 2 devices.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/mach-keystone/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index ea955f6db..7a432ee 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -11,6 +11,7 @@ config ARCH_KEYSTONE
 	select ZONE_DMA if ARM_LPAE
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
+	select PINCTRL
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
-- 
2.6.1
