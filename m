From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Thu, 26 Mar 2015 20:34:33 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable alpine platform
Message-ID: <55145139.nlWyMXDgc70PaKKp%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic PCI driver is required for SATA device probe on Alpine platform,
so it cannot be modular.

Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 06075b6..435ed5f 100644
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
@@ -91,6 +92,7 @@ CONFIG_ARCH_WM8850=y
 CONFIG_ARCH_ZYNQ=y
 CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_PCI=y
+CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_KEYSTONE=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_MVEBU=y
-- 
1.9.1
