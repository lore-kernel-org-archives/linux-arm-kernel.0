From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon,  7 Apr 2014 16:54:14 +0100
Subject: [PATCH v4 3/5] ARM: Conceal DEBUG_LL_UART_NONE from unsupported
 platforms
In-Reply-To: <1396886056-18132-1-git-send-email-daniel.thompson@linaro.org>
References: <1396626102-13991-1-git-send-email-daniel.thompson@linaro.org>
 <1396886056-18132-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1396886056-18132-4-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only a small handful of platforms support DEBUG_LL_UART_NONE but it
lurks in the menus of every single platform config ready to break the
build. This is an especial problem for defconfigs since it is often
selected by default.

This patch limit this choice only to platforms capable of supporting it.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/Kconfig.debug | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0531da8..0702d6d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -846,7 +846,18 @@ choice
 
 	config DEBUG_LL_UART_NONE
 		bool "No low-level debugging UART"
-		depends on !ARCH_MULTIPLATFORM
+		depends on ARCH_AT91 || \
+			ARCH_CLPS711X || \
+			ARCH_FOOTBRIDGE || \
+			ARCH_KS8695 || \
+			ARCH_NETX || \
+			ARCH_OMAP1 || \
+			ARCH_SA1100 || \
+			ARCH_S3C24XX || \
+			ARCH_S3C64XX || \
+			ARCH_S5P64X0 || \
+			ARCH_S5PC100 || \
+			ARCH_S5PV210
 		help
 		  Say Y here if your platform doesn't provide a UART option
 		  above. This relies on your platform choosing the right UART
-- 
1.9.0
