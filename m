From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri,  7 Dec 2012 21:06:28 +0000
Subject: [PATCH 3/7] arm64: SoC infrastructure preparation
In-Reply-To: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1354914392-9634-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the necessary Kconfig and Makefile modifications
together with skeleton.dtsi for SoC support.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                |  4 +++-
 arch/arm64/Makefile               |  3 ++-
 arch/arm64/boot/dts/skeleton.dtsi | 13 +++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/skeleton.dtsi
 create mode 100644 arch/arm64/platforms/Kconfig
 create mode 100644 arch/arm64/platforms/Makefile

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0f87a49..e58a35a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -95,7 +95,9 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
-menu "System Type"
+menu "Platform selection"
+
+source "arch/arm64/platforms/Kconfig"
 
 endmenu
 
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 64089bc..ddadd27 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -36,7 +36,8 @@ TEXT_OFFSET := 0x00080000
 
 export	TEXT_OFFSET GZFLAGS
 
-core-y		+= arch/arm64/kernel/ arch/arm64/mm/
+core-y		+= arch/arm64/kernel/ arch/arm64/mm/ \
+		   arch/arm64/platforms/
 libs-y		:= arch/arm64/lib/ $(libs-y)
 libs-y		+= $(LIBGCC)
 
diff --git a/arch/arm64/boot/dts/skeleton.dtsi b/arch/arm64/boot/dts/skeleton.dtsi
new file mode 100644
index 0000000..38ead82
--- /dev/null
+++ b/arch/arm64/boot/dts/skeleton.dtsi
@@ -0,0 +1,13 @@
+/*
+ * Skeleton device tree; the bare minimum needed to boot; just include and
+ * add a compatible value.  The bootloader will typically populate the memory
+ * node.
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	chosen { };
+	aliases { };
+	memory { device_type = "memory"; reg = <0 0 0>; };
+};
diff --git a/arch/arm64/platforms/Kconfig b/arch/arm64/platforms/Kconfig
new file mode 100644
index 0000000..e69de29
diff --git a/arch/arm64/platforms/Makefile b/arch/arm64/platforms/Makefile
new file mode 100644
index 0000000..e69de29
