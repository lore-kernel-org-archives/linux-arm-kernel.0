From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 17:00:34 +0530
Subject: [PATCH V6 10/11] ST SPEAr6xx: Rework Kconfig for single image solution
In-Reply-To: <cover.1298977709.git.viresh.kumar@st.com>
References: <cover.1298977709.git.viresh.kumar@st.com>
Message-ID: <85ae62f5f7148e9f9cc24d5603b171287b91d269.1298977709.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear6xx/Kconfig    |   15 ++++++++-------
 arch/arm/mach-spear6xx/Kconfig600 |   17 -----------------
 2 files changed, 8 insertions(+), 24 deletions(-)
 delete mode 100644 arch/arm/mach-spear6xx/Kconfig600

diff --git a/arch/arm/mach-spear6xx/Kconfig b/arch/arm/mach-spear6xx/Kconfig
index bddba03..ff4ae5b 100644
--- a/arch/arm/mach-spear6xx/Kconfig
+++ b/arch/arm/mach-spear6xx/Kconfig
@@ -4,17 +4,18 @@
 
 if ARCH_SPEAR6XX
 
-choice
-	prompt "SPEAr6XX Family"
-	default MACH_SPEAR600
+menu "SPEAr6xx Implementations"
+config BOARD_SPEAR600_EVB
+	bool "SPEAr600 Evaluation Board"
+	select MACH_SPEAR600
+	help
+	  Supports ST SPEAr600 Evaluation Board
+
+endmenu
 
 config MACH_SPEAR600
 	bool "SPEAr600"
 	help
 	  Supports ST SPEAr600 Machine
-endchoice
-
-# Adding SPEAr6XX machine specific configuration files
-source "arch/arm/mach-spear6xx/Kconfig600"
 
 endif #ARCH_SPEAR6XX
diff --git a/arch/arm/mach-spear6xx/Kconfig600 b/arch/arm/mach-spear6xx/Kconfig600
deleted file mode 100644
index 9e19f65..0000000
--- a/arch/arm/mach-spear6xx/Kconfig600
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# SPEAr600 machine configuration file
-#
-
-if MACH_SPEAR600
-
-choice
-	prompt "SPEAr600 Boards"
-	default BOARD_SPEAR600_EVB
-
-config	BOARD_SPEAR600_EVB
-	bool "SPEAr600 Evaluation Board"
-	help
-	  Supports ST SPEAr600 Evaluation Board
-endchoice
-
-endif	#MACH_SPEAR600
-- 
1.7.2.2
