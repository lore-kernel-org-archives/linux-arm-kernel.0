From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 29 May 2014 12:08:18 +0530
Subject: [PATCH v2 16/18] ARM: OMAP: Enable PCI for DRA7
In-Reply-To: <1401345500-20188-1-git-send-email-kishon@ti.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com>
Message-ID: <1401345500-20188-17-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have added PCIe driver for DRA7 SOCs, enable PCI on
DRA7 SOCs.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index cb31d43..b179e80 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -75,6 +75,8 @@ config SOC_DRA7XX
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
 	select IRQ_CROSSBAR
+	select MIGHT_HAVE_PCI
+	select ARCH_SUPPORTS_MSI
 
 config ARCH_OMAP2PLUS
 	bool
-- 
1.7.9.5
