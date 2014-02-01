From: robherring2@gmail.com (Rob Herring)
Date: Sat,  1 Feb 2014 16:35:42 -0600
Subject: [PATCH 1/3] ARM: hisi: fix kconfig warning on HAVE_ARM_TWD
In-Reply-To: <1391294144-27787-1-git-send-email-robherring2@gmail.com>
References: <1391294144-27787-1-git-send-email-robherring2@gmail.com>
Message-ID: <1391294144-27787-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Commit "ARM: hisi: don't select SMP" introduced a kconfig warning:
warning: (ARCH_HI3xxx) selects HAVE_ARM_TWD which has unmet direct dependencies (SMP)

Fix HAVE_ARM_TWD to depend on SMP.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-hisi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 8f4649b..1abae5f 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -8,7 +8,7 @@ config ARCH_HI3xxx
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU
-	select HAVE_ARM_TWD
+	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
 	select PINCTRL
 	select PINCTRL_SINGLE
-- 
1.8.3.2
