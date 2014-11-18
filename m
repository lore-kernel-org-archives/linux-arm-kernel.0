From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 18 Nov 2014 18:52:56 +0000
Subject: [PATCH v2 01/13] arm64: PCI/MSI: Use asm-generic/msi.h
In-Reply-To: <1416336788-22634-1-git-send-email-marc.zyngier@arm.com>
References: <1416336788-22634-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1416336788-22634-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support CONFIG_GENERIC_MSI_IRQ_DOMAIN, we need to
define msi_alloc_info_t. As the generic version exposed in
asm-generic/msi.h is perfectly convenient, import this file
as asm/msi.h.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index dc770bd..e315bd8 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -28,6 +28,7 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mman.h
 generic-y += msgbuf.h
+generic-y += msi.h
 generic-y += mutex.h
 generic-y += pci.h
 generic-y += pci-bridge.h
-- 
2.1.3
