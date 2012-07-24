From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 23 Jul 2012 21:09:03 -0400
Subject: [RFC 01/23] ARM: LPAE: disable phys-to-virt patching on PAE systems
In-Reply-To: <1343092165-9470-1-git-send-email-cyril@ti.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
Message-ID: <1343092165-9470-2-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vitaly Andrianov <vitalya@ti.com>

The current phys-to-virt patching mechanism is broken on PAE machines with
64-bit physical addressing.  This patch disables the patching mechanism in
such configurations.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a91009c..55da671 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -191,6 +191,7 @@ config ARM_PATCH_PHYS_VIRT
 	default y
 	depends on !XIP_KERNEL && MMU
 	depends on !ARCH_REALVIEW || !SPARSEMEM
+	depends on !ARCH_PHYS_ADDR_T_64BIT
 	help
 	  Patch phys-to-virt and virt-to-phys translation functions at
 	  boot and module load time according to the position of the
-- 
1.7.9.5
