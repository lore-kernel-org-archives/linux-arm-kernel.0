From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Feb 2016 09:47:44 +0100
Subject: [PATCH 4/5] arm64: update ARCH_MVEBU for Marvell Armada 7K/8K support
In-Reply-To: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1455526065-7307-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates the ARCH_MVEBU Kconfig option introduced for
Armada 3700 to also be used for the Armada 7K and 8K platforms, by:

 - Selecting the appropriate clock and irqchip drivers
 - Updating the help text to mention Armada 7K and 8K

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d6fee5c..cadb7ff 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -2,9 +2,14 @@ menu "Platform selection"
 
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
-	help
-	  This enables support for Marvell EBU familly such as the
-	  Armada 3700 SoC Family.
+	select ARMADA_AP806_CORE_CLK
+	select ARMADA_AP806_RING_CLK
+	select MVEBU_ODMI
+	help
+	  This enables support for Marvell EBU familly, including:
+	   - Armada 3700 SoC Family
+	   - Armada 7K SoC Family
+	   - Armada 8K SoC Family
 
 config ARCH_BCM_IPROC
 	bool "Broadcom iProc SoC Family"
-- 
2.6.4
