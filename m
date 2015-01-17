From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sat, 17 Jan 2015 19:15:15 +0100
Subject: [PATCH v4 2/3] ARM: meson: select PINCTRL_MESON and
 ARCH_REQUIRE_GPIOLIB
In-Reply-To: <1421518516-26976-1-git-send-email-b.galvani@gmail.com>
References: <1421518516-26976-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1421518516-26976-3-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that the Meson pinctrl driver is built whenever Meson
support is enabled.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-meson/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 18301dc..0743e20 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -1,8 +1,11 @@
 menuconfig ARCH_MESON
 	bool "Amlogic Meson SoCs" if ARCH_MULTI_V7
+	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_IRQ_CHIP
 	select ARM_GIC
 	select CACHE_L2X0
+	select PINCTRL
+	select PINCTRL_MESON
 
 if ARCH_MESON
 
-- 
2.1.4
