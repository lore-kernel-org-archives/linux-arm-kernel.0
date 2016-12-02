From: geoff@infradead.org (Geoff Levand)
Date: Fri, 2 Dec 2016 14:17:02 -0800
Subject: [PATCH] arm64: Add CMDLINE_EXTEND
Message-ID: <61060b44-64a9-d628-4faf-3a7ae06048aa@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree code already supports CMDLINE_EXTEND,
so add the config option to make it available on arm64.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 969ef88..51f7545 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -949,6 +949,12 @@ config CMDLINE
 	  entering them here. As a minimum, you should specify the the
 	  root device (e.g. root=/dev/nfs).
 
+config CMDLINE_EXTEND
+	bool "Extend bootloader kernel arguments"
+	help
+	  The command-line arguments provided by the boot loader will be
+	  appended to the default kernel command string.
+
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
 	help
-- 
2.9.3
