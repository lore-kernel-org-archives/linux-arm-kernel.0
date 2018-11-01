From: lsun@mellanox.com (Liming Sun)
Date: Thu,  1 Nov 2018 12:25:31 -0400
Subject: [PATCH v6 2/9] arm64: Add Mellanox BlueField SoC config option
In-Reply-To: <1541089538-175682-1-git-send-email-lsun@mellanox.com>
References: <1541089538-175682-1-git-send-email-lsun@mellanox.com>
Message-ID: <1541089538-175682-2-git-send-email-lsun@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit introduces config option for Mellanox BlueField SoC,
which can be used to build the SoC specific drivers, and enables
it by default in configs/defconfig.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 arch/arm64/configs/defconfig | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 393d2b5..1e28eb6 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -117,6 +117,12 @@ config ARCH_MESON
 	help
 	  This enables support for the Amlogic S905 SoCs.
 
+config ARCH_MLNX_BLUEFIELD
+	bool "Mellanox BlueField SoC Family"
+	select SOC_MLNX
+	help
+	  This enables support for the Mellanox BlueField SoC.
+
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
 	select ARMADA_AP806_SYSCON
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index db8d364..8865ada 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -44,6 +44,7 @@ CONFIG_ARCH_LG1K=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
+CONFIG_ARCH_MLNX_BLUEFIELD=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_ROCKCHIP=y
-- 
1.8.3.1
