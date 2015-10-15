From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:46:51 +0200
Subject: [PATCH 11/13] ARM: realview: select SP810 and ICST for the DT variant
In-Reply-To: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444916813-31024-12-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree boot for RealView need the SP810 system controller
(same as found on the Versatile Express) to set up the timers on the
board so the machine can tick. It further utilize the ICST307 through
its system controller for 6 other oscillators. We have to select these
from Kconfig or the machine does not boot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 565925f37dc5..ea0b1d13eef6 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -4,6 +4,8 @@ menu "RealView platform type"
 config REALVIEW_DT
 	bool "Support RealView(R) Device Tree based boot"
 	select ARM_GIC
+	select CLK_SP810
+	select ICST
 	select MFD_SYSCON
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
-- 
2.4.3
