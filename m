From: srinivas.kandagatla@st.com (srinivas.kandagatla at st.com)
Date: Mon, 3 Feb 2014 14:29:04 +0000
Subject: [PATCH v2 6/6] ARM: STi: Add reset controller support to mach-sti
 Kconfig
In-Reply-To: <1391437665-11913-1-git-send-email-srinivas.kandagatla@st.com>
References: <1391437665-11913-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1391437744-12184-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Gallimore <stephen.gallimore@st.com>

This patch selects reset controller support for ARCH_STI and
selects the reset controllers for STiH415 and STiH416 SoCs.

Signed-off-by: Stephen Gallimore <stephen.gallimore@st.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/mach-sti/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index d71654b..2550620 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -7,6 +7,7 @@ menuconfig ARCH_STI
 	select PINCTRL
 	select PINCTRL_ST
 	select MFD_SYSCON
+	select ARCH_HAS_RESET_CONTROLLER
 	select MIGHT_HAVE_CACHE_L2X0
 	select HAVE_SMP
 	select HAVE_ARM_SCU if SMP
@@ -28,6 +29,7 @@ if ARCH_STI
 config SOC_STIH415
 	bool "STiH415 STMicroelectronics Consumer Electronics family"
 	default y
+	select STIH415_RESET
 	help
 	  This enables support for STMicroelectronics Digital Consumer
 	  Electronics family StiH415 parts, primarily targeted at set-top-box
@@ -37,6 +39,7 @@ config SOC_STIH415
 config SOC_STIH416
 	bool "STiH416 STMicroelectronics Consumer Electronics family"
 	default y
+	select STIH416_RESET
 	help
 	  This enables support for STMicroelectronics Digital Consumer
 	  Electronics family StiH416 parts, primarily targeted at set-top-box
-- 
1.7.9.5
