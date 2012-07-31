From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 14:31:32 +0100
Subject: [PATCH 6/6] ARM: ux500: Enable HIGHMEM on all mop500 platforms
In-Reply-To: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343741493-17671-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current kernel commandline for ux500 based devices includes
hard-coded allocations for things like mali and hwmem, which
actually run over lowmem. Here we enable highmem in order to
avoid memory corruption errors.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index c013bbf..f51c351 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -28,6 +28,7 @@ config MACH_MOP500
 	select I2C
 	select I2C_NOMADIK
 	select SOC_BUS
+	select HIGHMEM
 	help
 	  Include support for the MOP500 development platform.
 
-- 
1.7.9.5
