From: will.deacon@arm.com (Will Deacon)
Date: Wed,  7 May 2014 17:07:17 +0100
Subject: [PATCH v6 1/3] ARM: kconfig: allow PCI support to be selected with
 ARCH_MULTIPLATFORM
In-Reply-To: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
References: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
Message-ID: <1399478839-3564-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When targetting ARCH_MULTIPLATFORM, we may include support for SoCs with
PCI-capable devices (e.g. mach-virt with virtio-pci).

This patch allows PCI support to be selected for these SoCs by selecting
CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_MULTIPLATFORM=y.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db3c5414223e..860bea828ac4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -314,6 +314,7 @@ config ARCH_MULTIPLATFORM
 	select CLKSRC_OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_PCI
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
-- 
1.9.2
