From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Sun, 05 Apr 2015 15:43:56 +0300
Subject: [PATCH v2 3/3] ARM: multi_v7_defconfig: enable alpine platform
Message-ID: <55212e0c.XlZX3XeU2wCa/MNm%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCI driver is required for SATA device probe on Alpine platform,
so it cannot be modular.

Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 48dfe88..ab86655 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -12,6 +12,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_CMDLINE_PARTITION=y
 CONFIG_ARCH_VIRT=y
+CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_375=y
@@ -92,6 +93,7 @@ CONFIG_ARCH_WM8850=y
 CONFIG_ARCH_ZYNQ=y
 CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_PCI=y
+CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_KEYSTONE=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_MVEBU=y
-- 
1.9.1
