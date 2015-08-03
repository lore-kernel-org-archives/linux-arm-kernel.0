From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  3 Aug 2015 21:24:45 +0200
Subject: [PATCH 1/2] arm64: Enable Marvell Berlin SoC family in Kconfig
In-Reply-To: <1438629886-6390-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1438629886-6390-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1438629886-6390-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>

This patch introduces ARCH_BERLIN to enable Marvell Berlin SoC family in
Kconfig.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
As discussed with Olof on IRC, this is Jisheng's Kconfig patch for
ARM64 Berlin. Olof agreed to rework this to finally land in
Kconfig.platforms, i.e. after
  eed6b3eb20b9 ("arm64: Split out platform options to separate Kconfig")

Sebastian
---
 arch/arm64/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0f6edb14b7e4..d5c615312d87 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -162,6 +162,12 @@ source "kernel/Kconfig.freezer"
 
 menu "Platform selection"
 
+config ARCH_BERLIN
+	bool "Marvell Berlin SoC Family"
+	select DW_APB_ICTL
+	help
+	  This enables support for Marvell Berlin SoC Family
+
 config ARCH_EXYNOS
 	bool
 	help
-- 
2.1.0
