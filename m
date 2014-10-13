From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 13 Oct 2014 12:33:44 +0200
Subject: [PATCH 02/12] amba: Add Kconfig file
In-Reply-To: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1413196434-5292-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Rather than duplicate the ARM_AMBA Kconfig symbol in both 32-bit and
64-bit ARM architectures, move the common definition to drivers/amba
where dependent drivers will be located.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/Kconfig     | 3 ---
 arch/arm64/Kconfig   | 3 ---
 drivers/amba/Kconfig | 2 ++
 3 files changed, 2 insertions(+), 6 deletions(-)
 create mode 100644 drivers/amba/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 89c4b5ccc68d..77f8ca5cc3e6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1259,9 +1259,6 @@ source "arch/arm/common/Kconfig"
 
 menu "Bus support"
 
-config ARM_AMBA
-	bool
-
 config ISA
 	bool
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ac9afde76dea..9442ff1209d5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -165,9 +165,6 @@ endmenu
 
 menu "Bus support"
 
-config ARM_AMBA
-	bool
-
 config PCI
 	bool "PCI support"
 	help
diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
new file mode 100644
index 000000000000..d1cba6a9b3b8
--- /dev/null
+++ b/drivers/amba/Kconfig
@@ -0,0 +1,2 @@
+config ARM_AMBA
+	bool
-- 
2.1.2
