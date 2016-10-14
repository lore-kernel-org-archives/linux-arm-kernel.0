From: niklas.cassel@axis.com (Niklas Cassel)
Date: Fri, 14 Oct 2016 15:08:35 +0200
Subject: [RESEND PATCH 2/3] ARM: ARTPEC-6: add pcie related options
Message-ID: <1476450515-4557-1-git-send-email-niklass@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas Cassel <niklas.cassel@axis.com>

Now that the ARTPEC-6 PCIe controller is merged, add pcie related options
by default for MACH_ARTPEC6 so that the driver can be enabled in the build.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/mach-artpec/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-artpec/Kconfig b/arch/arm/mach-artpec/Kconfig
index 85a962a..f158890 100644
--- a/arch/arm/mach-artpec/Kconfig
+++ b/arch/arm/mach-artpec/Kconfig
@@ -15,6 +15,8 @@ config MACH_ARTPEC6
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
 	select MFD_SYSCON
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
 	help
 	  Support for Axis ARTPEC-6 ARM Cortex A9 Platform
 
-- 
2.1.4
