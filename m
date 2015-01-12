From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 12 Jan 2015 17:14:33 +0800
Subject: [PATCH v4 4/4] arm64: mediatek: Add MT8173 SoC Kconfig and defconfig
In-Reply-To: <1421054073-43468-1-git-send-email-eddie.huang@mediatek.com>
References: <1421054073-43468-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1421054073-43468-5-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MT8173 arm64 Kconfig and defconfig files

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 arch/arm64/Kconfig           | 6 ++++++
 arch/arm64/configs/defconfig | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1f9a20..e627ead 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -148,6 +148,12 @@ source "kernel/Kconfig.freezer"
 
 menu "Platform selection"
 
+config ARCH_MEDIATEK
+	bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
+	select ARM_GIC
+	help
+	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
+
 config ARCH_SEATTLE
 	bool "AMD Seattle SoC Family"
 	help
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dd301be..ed84d21 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -32,6 +32,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
@@ -87,6 +88,7 @@ CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
1.8.1.1.dirty
