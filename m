From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 May 2014 17:41:14 +0100
Subject: [RESEND PATCH 1/3] ARM: mach-virt: allow PCI support to be selected
In-Reply-To: <1399048876-11862-1-git-send-email-will.deacon@arm.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com>
Message-ID: <1399048876-11862-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-virt can make use of virtio-pci devices, which requires the guest
kernel to have PCI support selected.

This patch selects CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_VIRT=y.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db3c5414223e..f24356c4d630 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -941,6 +941,7 @@ config ARCH_VIRT
 	select ARM_GIC
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
+	select MIGHT_HAVE_PCI
 
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
-- 
1.9.2
