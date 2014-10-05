From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun,  5 Oct 2014 23:59:13 +0200
Subject: [PATCH v2 1/7] ARM: meson: add meson8 support
In-Reply-To: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
References: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1412546359-15062-2-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a MACH_MESON8 symbol and add "amlogic,meson8" to the list of
compatible strings for the Meson DT machine to support devices based
on the Meson8 family of SoCs.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 arch/arm/mach-meson/Kconfig | 5 +++++
 arch/arm/mach-meson/meson.c | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

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
index 5ee064f..8f42d8f 100644
--- a/arch/arm/mach-meson/meson.c
+++ b/arch/arm/mach-meson/meson.c
@@ -16,12 +16,12 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 
-static const char * const m6_common_board_compat[] = {
+static const char * const meson_common_board_compat[] = {
 	"amlogic,meson6",
+	"amlogic,meson8",
 	NULL,
 };
 
-DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
-	.dt_compat	= m6_common_board_compat,
+DT_MACHINE_START(MESON, "Amlogic Meson platform")
+	.dt_compat	= meson_common_board_compat,
 MACHINE_END
-
-- 
1.9.1
