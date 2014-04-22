From: robherring2@gmail.com (Rob Herring)
Date: Tue, 22 Apr 2014 14:41:18 -0500
Subject: [PATCH 3/3] ARM: qcom: clean-up unneeded kconfig selects
In-Reply-To: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
References: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
Message-ID: <1398195678-28787-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Multi-platform support implies all these options are already selected and
individual platforms don't need to select them.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: linux-arm-msm at vger.kernel.org
---
 arch/arm/mach-qcom/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index a028be2..6aa2214 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -3,8 +3,6 @@ config ARCH_QCOM
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select CLKSRC_OF
-	select GENERIC_CLOCKEVENTS
-	select HAVE_SMP
 	select QCOM_SCM if SMP
 	help
 	  Support for Qualcomm's devicetree based systems.
-- 
1.9.1
