From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  7 Sep 2012 17:55:33 +0100
Subject: [PATCH v2 6/7] ARM: virt: Add CONFIG_ARM_VIRT_EXT option
In-Reply-To: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1347036934-8519-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

It is now possible to enable the virtualization extention support.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mm/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 101b968..c9a4963 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -624,6 +624,23 @@ config ARM_THUMBEE
 	  Say Y here if you have a CPU with the ThumbEE extension and code to
 	  make use of it. Say N for code that can run on CPUs without ThumbEE.
 
+config ARM_VIRT_EXT
+	bool "Native support for the ARM Virtualization Extensions"
+	depends on MMU && CPU_V7
+	help
+	  Enable the kernel to make use of the ARM Virtualization
+	  Extensions to install hypervisors without run-time firmware
+	  assistance.
+
+	  A compliant bootloader is required in order to make maximum
+	  use of this feature.  Refer to Documentation/arm/Booting for
+	  details.
+
+	  It is safe to enable this option even if the kernel may not be
+	  booted in HYP mode, may not have support for the
+	  virtualization extensions, or may be booted with a
+	  non-compliant bootloader.
+
 config SWP_EMULATE
 	bool "Emulate SWP/SWPB instructions"
 	depends on !CPU_USE_DOMAINS && CPU_V7
-- 
1.7.12
