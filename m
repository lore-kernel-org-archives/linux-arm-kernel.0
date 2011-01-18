From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 18 Jan 2011 12:41:36 +0530
Subject: [PATCH V4 08/62] ST SPEAr: Adding support for SPEAr13xx SoC in spear
	generic plat/
In-Reply-To: <cover.1295333957.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
Message-ID: <b8aafa15e846578012efd2e9d6a11072a6686dbe.1295333958.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/Kconfig |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
index 1bb3dbc..29a25d2 100644
--- a/arch/arm/plat-spear/Kconfig
+++ b/arch/arm/plat-spear/Kconfig
@@ -8,6 +8,13 @@ choice
 	prompt "ST SPEAr Family"
 	default ARCH_SPEAR3XX
 
+config ARCH_SPEAR13XX
+	bool "SPEAr13XX"
+	select ARM_GIC
+	select CPU_V7
+	help
+	  Supports for ARM's SPEAR13XX family
+
 config ARCH_SPEAR3XX
 	bool "SPEAr3XX"
 	select ARM_VIC
@@ -25,6 +32,7 @@ config ARCH_SPEAR6XX
 endchoice
 
 # Adding SPEAr machine specific configuration files
+source "arch/arm/mach-spear13xx/Kconfig"
 source "arch/arm/mach-spear3xx/Kconfig"
 source "arch/arm/mach-spear6xx/Kconfig"
 
-- 
1.7.2.2
