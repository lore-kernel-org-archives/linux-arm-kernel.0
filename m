From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 10 Nov 2014 10:32:35 +0900
Subject: [PATCH 3/3] ARM: shmobile: Enable PCI domains for R-Car Gen2 devices
In-Reply-To: <cover.1415581286.git.horms+renesas@verge.net.au>
References: <cover.1415581286.git.horms+renesas@verge.net.au>
Message-ID: <950a3f0e7dd32c372c9957d5c050b08de7ec9e56.1415581286.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The PCI core will soon automatically handle the PCI domain number,
allowing the internal PCI and external PCIe bridges work at the same time.
In order for that to work, we need to enable PCI_DOMAINS.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6bc018f..b0a9e1a 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -19,6 +19,7 @@ config ARCH_RCAR_GEN2
 	select PM_RCAR if PM || SMP
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
+	select PCI_DOMAINS if PCI
 
 config ARCH_RMOBILE
 	bool
-- 
2.1.1
