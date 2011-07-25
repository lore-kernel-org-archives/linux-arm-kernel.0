From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 25 Jul 2011 10:19:22 -0700
Subject: [PATCHv2 2/2] ARM: ARM_PATCH_PHYS_VIRT_16BIT no longer depends on MSM
In-Reply-To: <1311614362-9011-1-git-send-email-sboyd@codeaurora.org>
References: <1311614362-9011-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1311614362-9011-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MSM no longer requires the 16bit version of dynamic P2V. Drop the
dependency.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: David Brown <davidb@codeaurora.org>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c24f97a..da4508d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -209,8 +209,8 @@ config ARM_PATCH_PHYS_VIRT
 	  for the MSM machine class.
 
 config ARM_PATCH_PHYS_VIRT_16BIT
-	def_bool y
-	depends on ARM_PATCH_PHYS_VIRT && ARCH_MSM
+	bool
+	depends on ARM_PATCH_PHYS_VIRT
 	help
 	  This option extends the physical to virtual translation patching
 	  to allow physical memory down to a theoretical minimum of 64K
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
