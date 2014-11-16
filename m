From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 16 Nov 2014 21:14:16 +0100
Subject: [PATCH v3 3/3] ARM: meson: select PINCTRL_MESON and
 ARCH_REQUIRE_GPIOLIB
In-Reply-To: <1416168856-12747-1-git-send-email-b.galvani@gmail.com>
References: <1416168856-12747-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1416168856-12747-4-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that the Meson pinctrl driver is built whenever Meson
support is enabled.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 arch/arm/mach-meson/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 2c1154e..1828711 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -1,7 +1,10 @@
 menuconfig ARCH_MESON
 	bool "Amlogic Meson SoCs" if ARCH_MULTI_V7
+	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_IRQ_CHIP
 	select ARM_GIC
+	select PINCTRL
+	select PINCTRL_MESON
 
 if ARCH_MESON
 
-- 
1.9.1
