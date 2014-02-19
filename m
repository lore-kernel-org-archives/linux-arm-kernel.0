From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 19 Feb 2014 15:12:39 +0100
Subject: [Patch v3 08/23] ARM: MVEBU: Add ARCH_MULTI_V7 to SoCs
In-Reply-To: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392819174-11634-9-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare mach-mvebu to house both ARCH_MULTI_V7 and ARCH_MULTI_V5
systems by adding ARCH_MULTI_V7 to the existing SOCs.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mvebu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 5e269d7263ce..9ab22e1b26cd 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -29,7 +29,7 @@ config MACH_ARMADA_370_XP
 	select CPU_PJ4B
 
 config MACH_ARMADA_370
-	bool "Marvell Armada 370 boards"
+	bool "Marvell Armada 370 boards" if ARCH_MULTI_V7
 	select ARMADA_370_CLK
 	select MACH_ARMADA_370_XP
 	select PINCTRL_ARMADA_370
@@ -38,7 +38,7 @@ config MACH_ARMADA_370
 	  on the Marvell Armada 370 SoC with device tree.
 
 config MACH_ARMADA_XP
-	bool "Marvell Armada XP boards"
+	bool "Marvell Armada XP boards" if ARCH_MULTI_V7
 	select ARMADA_XP_CLK
 	select MACH_ARMADA_370_XP
 	select PINCTRL_ARMADA_XP
-- 
1.8.5.3
