From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 27 Mar 2016 11:40:33 +0200
Subject: [PATCH 1/4] arm64: marvell: enable AP806 and CP110 syscon driver
In-Reply-To: <1459071636-27687-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459071636-27687-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1459071636-27687-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 7K/8K support needs the AP806 and CP110 syscon
drivers to be enabled, as they provide amongst other things, the main
clocks for those platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index efa77c1..60f4bb5 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -64,8 +64,8 @@ config ARCH_MESON
 
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
-	select ARMADA_AP806_CORE_CLK
-	select ARMADA_AP806_RING_CLK
+	select ARMADA_AP806_SYSCON
+	select ARMADA_CP110_SYSCON
 	select MVEBU_ODMI
 	help
 	  This enables support for Marvell EBU familly, including:
-- 
2.6.4
