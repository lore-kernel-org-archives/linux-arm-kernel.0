From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  2 Jul 2014 15:08:48 +0100
Subject: [PATCH v2 3/4] ARM: sti: Add STiH407 Kconfig entry to select
 STIH407_RESET
In-Reply-To: <1404310129-14667-1-git-send-email-peter.griffin@linaro.org>
References: <1404310129-14667-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1404310129-14667-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The STiH407 is a STMicroelectronics Digital Consumer electronics
family, targetted at set-top-box and other audio/video applications.

This patch selects the reset controller driver for this family which
is essential to take various IP's on the SoC out of powerdown / reset.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-sti/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 878e9ec..8825bc9 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -42,4 +42,14 @@ config SOC_STIH416
 	  and other digital audio/video applications using Flattened Device
 	  Trees.
 
+config SOC_STIH407
+	bool "STiH407 STMicroelectronics Consumer Electronics family"
+	default y
+	select STIH407_RESET
+	help
+	  This enables support for STMicroelectronics Digital Consumer
+	  Electronics family StiH407 parts, targetted at set-top-box
+	  and other digital audio/video applications using Flattened Device
+	  Trees.
+
 endif
-- 
1.9.1
