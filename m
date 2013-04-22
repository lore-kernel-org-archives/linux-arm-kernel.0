From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon, 22 Apr 2013 13:43:24 +0100
Subject: [PATCH v1] ARM: do not select ARCH_VEXPRESS by default on
 ARCH_MULTI_V7
Message-ID: <1366634604-12637-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes ARCH_VEXPRESS selection as default when ARCH_MULTI_V7
is selected. ARCH_VEXPRESS should be selected from
mach-vexpress/Kconfig.

Without this patch, any multiplatform build will have ARCH_VEXPRESS
selected, as a result all the vexpress associated dtbs are build when we
make dtbs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1cacda4..e67d49d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1014,7 +1014,6 @@ config ARCH_MULTI_V7
 	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
 	default y
 	select ARCH_MULTI_V6_V7
-	select ARCH_VEXPRESS
 	select CPU_V7
 
 config ARCH_MULTI_V6_V7
-- 
1.7.6.5
