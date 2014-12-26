From: eddie.huang@mediatek.com (Eddie Huang)
Date: Fri, 26 Dec 2014 16:26:57 +0800
Subject: [PATCH v3 4/4] arm64: mediatek: Add MT8173 SoC Kconfig and defconfig
In-Reply-To: <1419582417-4448-1-git-send-email-eddie.huang@mediatek.com>
References: <1419582417-4448-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1419582417-4448-5-git-send-email-eddie.huang@mediatek.com>
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
1.8.1.1

************* Email Confidentiality Notice ********************
The information contained in this e-mail message (including any 
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be 
conveyed only to the designated recipient(s). Any use, dissemination, 
distribution, printing, retaining or copying of this e-mail (including its 
attachments) by unintended recipient(s) is strictly prohibited and may 
be unlawful. If you are not an intended recipient of this e-mail, or believe 
that you have received this e-mail in error, please notify the sender 
immediately (by replying to this e-mail), delete any and all copies of 
this e-mail (including any attachments) from your system, and do not
disclose the content of this e-mail to any other person. Thank you!
