From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  7 May 2012 09:16:14 +0800
Subject: [PATCH RESEND 9/9] ARM: mxs: enable pinctrl support
In-Reply-To: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336353374-28939-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig          |    1 +
 arch/arm/mach-mxs/Kconfig |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf006d4..c67494f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -469,6 +469,7 @@ config ARCH_MXS
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select HAVE_CLK_PREPARE
+	select PINCTRL
 	help
 	  Support for Freescale MXS-based family of processors
 
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index c57f996..07d5383 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -9,11 +9,13 @@ config SOC_IMX23
 	bool
 	select CPU_ARM926T
 	select HAVE_PWM
+	select PINCTRL_IMX23
 
 config SOC_IMX28
 	bool
 	select CPU_ARM926T
 	select HAVE_PWM
+	select PINCTRL_IMX28
 
 comment "MXS platforms:"
 
-- 
1.7.5.4
