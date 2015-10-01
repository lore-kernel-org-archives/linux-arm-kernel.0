From: carlo@caione.org (Carlo Caione)
Date: Thu,  1 Oct 2015 13:38:34 +0200
Subject: [PATCH 4/4] ARM: meson: Enable Meson8b SoCs
In-Reply-To: <1443699514-11590-1-git-send-email-carlo@caione.org>
References: <1443699514-11590-1-git-send-email-carlo@caione.org>
Message-ID: <1443699514-11590-5-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/mach-meson/Kconfig | 5 +++++
 arch/arm/mach-meson/meson.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 0743e20..5d56f86 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -19,4 +19,9 @@ config MACH_MESON8
 	default ARCH_MESON
 	select MESON6_TIMER
 
+config MACH_MESON8B
+	bool "Amlogic Meson8b SoCs support"
+	default ARCH_MESON
+	select MESON6_TIMER
+
 endif
diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
index 5d6affe..4e23571 100644
--- a/arch/arm/mach-meson/meson.c
+++ b/arch/arm/mach-meson/meson.c
@@ -19,6 +19,7 @@
 static const char * const meson_common_board_compat[] = {
 	"amlogic,meson6",
 	"amlogic,meson8",
+	"amlogic,meson8b",
 	NULL,
 };
 
-- 
1.9.1
