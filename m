From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Tue, 4 Nov 2014 17:38:28 +0000
Subject: [PATCH] ARM: shmobile: Enable PCI domains for R-Car Gen2 devices
Message-ID: <1415122708-4011-1-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCI core will soon automatically handle the PCI domain number,
allowing the internal PCI and external PCIe bridges work at the same time.
In order for that to work, we need to enable PCI_DOMAINS.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---

In order to automatically handle the PCI domain number, we need a patch from
Lorenzo Pieralisi:
 "[RFC PATCH 2/2] arm: pcibios: move to generic PCI domains"
However, enabling PCI_DOMAINS without this doesn't have an adverse effect,
and the plan is to use PCI domains to solve this problem, so we can apply
this patch straight away.

 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 21f457b..1c05768 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -18,6 +18,7 @@ config ARCH_RCAR_GEN2
 	select PM_RCAR if PM || SMP
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
+	select PCI_DOMAINS if PCI
 
 config ARCH_RMOBILE
 	bool
-- 
1.9.1
