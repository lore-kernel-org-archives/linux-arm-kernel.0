From: olof@lixom.net (Olof Johansson)
Date: Thu,  6 Oct 2011 19:54:17 -0700
Subject: [PATCH 07/14] ARM: tegra: pcie: don't cast __iomem pointers
In-Reply-To: <1317956064-17650-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
Message-ID: <1317956064-17650-8-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes a bunch of:

arch/arm/mach-tegra/pcie.c:678:8: warning: cast removes address space of expression
arch/arm/mach-tegra/pcie.c:678:8: warning: incorrect type in argument 1 (different base types)
arch/arm/mach-tegra/pcie.c:678:8:    expected void const volatile [noderef] <asn:2>*<noident>
arch/arm/mach-tegra/pcie.c:678:8:    got unsigned int
arch/arm/mach-tegra/pcie.c:678:8: warning: cast removes address space of expression

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/pcie.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index f1f699d..6b0c235 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -150,9 +150,9 @@
 static void __iomem *reg_pmc_base = IO_ADDRESS(TEGRA_PMC_BASE);
 
 #define pmc_writel(value, reg) \
-	__raw_writel(value, (u32)reg_pmc_base + (reg))
+	__raw_writel(value, reg_pmc_base + (reg))
 #define pmc_readl(reg) \
-	__raw_readl((u32)reg_pmc_base + (reg))
+	__raw_readl(reg_pmc_base + (reg))
 
 /*
  * Tegra2 defines 1GB in the AXI address map for PCIe.
-- 
1.7.4.1
