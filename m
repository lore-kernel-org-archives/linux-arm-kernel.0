From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 20 Dec 2010 13:55:29 +0530
Subject: [PATCH V3 08/63] ST SPEAr: Adding support for SPEAr13xx SoC in spear
	generic plat/
In-Reply-To: <cover.1292833228.git.viresh.kumar@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
Message-ID: <a87f14e1f6f100ce41948d2da880560d6cfccb29.1292833228.git.viresh.kumar@st.com>
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
