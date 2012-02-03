From: robherring2@gmail.com (Rob Herring)
Date: Fri,  3 Feb 2012 16:35:09 -0600
Subject: [PATCH v4 1/4] ARM: kconfig: always select IRQ_DOMAIN
In-Reply-To: <1328308512-22594-1-git-send-email-robherring2@gmail.com>
References: <1328308512-22594-1-git-send-email-robherring2@gmail.com>
Message-ID: <1328308512-22594-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

irqdomains should ultimately be needed for all platforms, so enable it
unconditionally for ARM.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig        |    2 +-
 arch/arm/common/Kconfig |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24626b0..b21b396 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -32,6 +32,7 @@ config ARM
 	select GENERIC_IRQ_SHOW
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select GENERIC_PCI_IOMAP
+	select IRQ_DOMAIN
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
@@ -1862,7 +1863,6 @@ config USE_OF
 	bool "Flattened Device Tree support"
 	select OF
 	select OF_EARLY_FLATTREE
-	select IRQ_DOMAIN
 	help
 	  Include support for flattened device tree machine descriptions.
 
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 81a933e..2d3fc0c 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -1,5 +1,4 @@
 config ARM_GIC
-	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
 	bool
 
@@ -7,7 +6,6 @@ config GIC_NON_BANKED
 	bool
 
 config ARM_VIC
-	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
 	bool
 
-- 
1.7.5.4
