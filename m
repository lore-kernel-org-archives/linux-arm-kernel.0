From: lsun@mellanox.com (Liming Sun)
Date: Wed, 24 Oct 2018 13:55:32 -0400
Subject: [PATCH v4 2/4] arm64: Add Mellanox BlueField SoC config option
In-Reply-To: <1540403734-137721-1-git-send-email-lsun@mellanox.com>
References: <1540403734-137721-1-git-send-email-lsun@mellanox.com>
Message-ID: <1540403734-137721-2-git-send-email-lsun@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit introduces config option for Mellanox BlueField SoC,
which can be used to build the SoC specific drivers, and enables
it by default in configs/defconfig.

Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 arch/arm64/configs/defconfig | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d5aeac3..aeb67c2 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -110,6 +110,12 @@ config ARCH_MESON
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
index f9a186f..508cb9d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -43,6 +43,7 @@ CONFIG_ARCH_LG1K=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
+CONFIG_ARCH_MLNX_BLUEFIELD=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_ROCKCHIP=y
-- 
1.8.3.1
