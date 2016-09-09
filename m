From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  9 Sep 2016 23:25:33 +0200
Subject: [PATCH 4/6] ARM: nomadik: select MFD_SYSCON
In-Reply-To: <1473456335-22767-1-git-send-email-linus.walleij@linaro.org>
References: <1473456335-22767-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1473456335-22767-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the Power Management Unit is using syscon to access a
set of necessary hardware muxing, let's select MFD_SYSCON for
the Nomadik subarchitecture.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index b7e9801fdaa4..3ae45b8d7b0a 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -7,6 +7,7 @@ menuconfig ARCH_NOMADIK
 	select CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 	select CPU_ARM926T
 	select GPIOLIB
+	select MFD_SYSCON
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
 	select PINCTRL_NOMADIK
-- 
2.7.4
