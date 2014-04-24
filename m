From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 24 Apr 2014 17:00:44 +0100
Subject: [RESEND PATCH v5 3/5] ARM: Conceal DEBUG_LL_UART_NONE from
 unsupported platforms
In-Reply-To: <1398355246-29571-1-git-send-email-daniel.thompson@linaro.org>
References: <1396886056-18132-1-git-send-email-daniel.thompson@linaro.org>
 <1398355246-29571-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1398355246-29571-4-git-send-email-daniel.thompson@linaro.org>
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
index 4a2fc0b..450e6f7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -842,7 +842,18 @@ choice
 
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
