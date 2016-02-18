From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Feb 2016 17:20:29 +0100
Subject: [PATCH v2 5/6] arm64: update ARCH_MVEBU for Marvell Armada 7K/8K
 support
In-Reply-To: <1455812430-4656-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455812430-4656-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1455812430-4656-6-git-send-email-thomas.petazzoni@free-electrons.com>
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
index 85bec42..c9a184b 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -50,9 +50,14 @@ config ARCH_MEDIATEK
 
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
-	help
-	  This enables support for Marvell EBU family such as the
-	  Armada 3700 SoC family.
+	select ARMADA_AP806_CORE_CLK
+	select ARMADA_AP806_RING_CLK
+	select MVEBU_ODMI
+	help
+	  This enables support for Marvell EBU familly, including:
+	   - Armada 3700 SoC Family
+	   - Armada 7K SoC Family
+	   - Armada 8K SoC Family
 
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
-- 
2.6.4
