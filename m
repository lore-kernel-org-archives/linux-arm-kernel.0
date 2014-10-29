From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 29 Oct 2014 12:45:31 -0400
Subject: [PATCH v1 1/4] ARM: keystone: add pcie related options
In-Reply-To: <1414601134-31825-1-git-send-email-m-karicheri2@ti.com>
References: <1414601134-31825-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1414601134-31825-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that Keystone PCI controller is merged, add pcie related options
by default for keystone architecture so that driver can be enabled in
the build.


Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Santosh Shilimkar <ssantosh@kernel.org>
---
 - v1 - No change w.r.t 
 arch/arm/mach-keystone/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 98a156a..ea955f6db 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -9,6 +9,8 @@ config ARCH_KEYSTONE
 	select COMMON_CLK_KEYSTONE
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ZONE_DMA if ARM_LPAE
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
-- 
1.7.9.5
