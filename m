From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Mon,  4 May 2015 15:42:18 +0300
Subject: [PATCH v2 5/5] ARM: qcom: Add Qualcomm APQ8084 SoC
In-Reply-To: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com>
References: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com>
Message-ID: <1430743338-10441-6-git-send-email-svarbanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds Snapdragon 805 ARM-based SoC as multiplatform
compatible platform.

Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
---
 arch/arm/mach-qcom/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 2256cd1..9cfebee 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -22,4 +22,11 @@ config ARCH_MSM8974
 	bool "Enable support for MSM8974"
 	select HAVE_ARM_ARCH_TIMER
 
+config ARCH_APQ8084
+	bool "Enable support for APQ8084"
+	select HAVE_ARM_ARCH_TIMER
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
+	select PCI_MSI if PCI
+
 endif
-- 
1.7.0.4
