From: b.galvani@gmail.com (Beniamino Galvani)
Date: Wed,  1 Oct 2014 23:29:41 +0200
Subject: [PATCH 1/6] ARM: meson: add meson8 machine definition
In-Reply-To: <1412198986-26534-1-git-send-email-b.galvani@gmail.com>
References: <1412198986-26534-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1412198986-26534-2-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a machine definition for Amlogic Meson8 SoCs.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 arch/arm/mach-meson/Kconfig | 5 +++++
 arch/arm/mach-meson/meson.c | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 2c1154e..b289e8e 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -10,4 +10,9 @@ config MACH_MESON6
 	default ARCH_MESON
 	select MESON6_TIMER
 
+config MACH_MESON8
+	bool "Amlogic Meson8 SoCs support"
+	default ARCH_MESON
+	select MESON6_TIMER
+
 endif
diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
index 5ee064f..e95d6ae 100644
--- a/arch/arm/mach-meson/meson.c
+++ b/arch/arm/mach-meson/meson.c
@@ -21,7 +21,15 @@ static const char * const m6_common_board_compat[] = {
 	NULL,
 };
 
+static const char * const m8_common_board_compat[] = {
+	"amlogic,meson8",
+	NULL,
+};
+
 DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
 	.dt_compat	= m6_common_board_compat,
 MACHINE_END
 
+DT_MACHINE_START(MESON8, "Amlogic Meson8 platform")
+	.dt_compat	= m8_common_board_compat,
+MACHINE_END
-- 
1.9.1
