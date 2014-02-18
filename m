From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Feb 2014 12:20:41 +0000
Subject: [PATCH v3 1/3] ARM: mach-virt: allow PCI support to be selected
In-Reply-To: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
Message-ID: <1392726043-31088-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-virt can make use of virtio-pci devices, which requires the guest
kernel to have PCI support selected.

This patch selects CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_VIRT=y.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-virt/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-virt/Kconfig b/arch/arm/mach-virt/Kconfig
index 081d46929436..f40fb55574cb 100644
--- a/arch/arm/mach-virt/Kconfig
+++ b/arch/arm/mach-virt/Kconfig
@@ -8,3 +8,4 @@ config ARCH_VIRT
 	select CPU_V7
 	select SPARSE_IRQ
 	select USE_OF
+	select MIGHT_HAVE_PCI
-- 
1.8.2.2
