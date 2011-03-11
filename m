From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 11 Mar 2011 16:08:03 -0700
Subject: [PATCH 01/10] ux500: Introducing foundation for snowball board.
In-Reply-To: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1299884892-6766-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/Kconfig                   |    6 ++++++
 arch/arm/mach-ux500/include/mach/uncompress.h |    3 ++-
 arch/arm/tools/mach-types                     |    1 +
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 7f8620f..ba5c270 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -26,6 +26,12 @@ config MACH_U8500
 	help
 	  Include support for the mop500 development platform.
 
+config MACH_U8500_SNOWBALL
+	bool "U8500 Snowball platform"
+	depends on UX500_SOC_DB8500
+	help
+	  Include support for the snowball development platform.
+
 config MACH_U5500
 	bool "U5500 Development platform"
 	depends on UX500_SOC_DB5500
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index ab0fe14..3b4f6b7 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -54,7 +54,8 @@ static inline void arch_decomp_setup(void)
 	if (machine_is_u8500() ||
 	    machine_is_svp8500v1() ||
 	    machine_is_svp8500v2() ||
-	    machine_is_hrefv60())
+	    machine_is_hrefv60()   ||
+	    machine_is_snowball())
 		ux500_uart_base = U8500_UART2_BASE;
 	else if (machine_is_u5500())
 		ux500_uart_base = U5500_UART0_BASE;
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 9d6feaa..e9f780e 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -3316,3 +3316,4 @@ rover_g8		MACH_ROVER_G8		ROVER_G8		3335
 t5388p			MACH_T5388P		T5388P			3336
 dingo			MACH_DINGO		DINGO			3337
 goflexhome		MACH_GOFLEXHOME		GOFLEXHOME		3338
+snowball		MACH_U8500_SNOWBALL	SNOWBALL		3363
-- 
1.7.1
