From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:33 +0200
Subject: [PATCH 02/10] ARM: shmobile: defconfig: Enable missing PCIE_RCAR
 dependency
In-Reply-To: <cover.1501511664.git.horms+renesas@verge.net.au>
References: <cover.1501511664.git.horms+renesas@verge.net.au>
Message-ID: <b217113362f9e24e68ce849fc2fef7a1d2e40b82.1501511664.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

PCIE_RCAR is no longer enabled, as it now has a dependency on
PCI_MSI_IRQ_DOMAIN instead of selecting PCI_MSI and PCI_MSI_IRQ_DOMAIN.
Fix this by explicitly enabling PCIE_RCAR in shmobile_defconfig.

Fixes: 3ee803641e76bea7 ("PCI/MSI: irqchip: Fix PCI_MSI dependencies")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index d9929114d47b..297ef8e584f3 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -27,6 +27,7 @@ CONFIG_ARCH_SH73A0=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_PCI=y
+CONFIG_PCI_MSI=y
 CONFIG_PCI_RCAR_GEN2=y
 CONFIG_PCIE_RCAR=y
 CONFIG_SMP=y
-- 
2.1.4
