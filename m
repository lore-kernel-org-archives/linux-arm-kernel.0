From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  1 Feb 2016 21:35:56 +0100
Subject: [PATCH 2/4] ARM: davinci: avoid unused mityomapl138_pn_info variable
In-Reply-To: <1454358962-640598-1-git-send-email-arnd@arndb.de>
References: <1454358962-640598-1-git-send-email-arnd@arndb.de>
Message-ID: <1454358962-640598-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mityomapl138_pn_info structure belongs into the CPU_FREQ support
that is hidden behind an #ifdef, and causes a harmless warning when
that support is disabled:

mach-davinci/board-mityomapl138.c:59:28: error: 'mityomapl138_pn_info' defined but not used [-Werror=unused-variable]

This moves the variable definition where it belongs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index de1316bf643a..c1f4b34785db 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -51,6 +51,7 @@ struct factory_config {
 
 static struct factory_config factory_config;
 
+#ifdef CONFIG_CPU_FREQ
 struct part_no_info {
 	const char	*part_no;	/* part number string of interest */
 	int		max_freq;	/* khz */
@@ -87,7 +88,6 @@ static struct part_no_info mityomapl138_pn_info[] = {
 	},
 };
 
-#ifdef CONFIG_CPU_FREQ
 static void mityomapl138_cpufreq_init(const char *partnum)
 {
 	int i, ret;
-- 
2.7.0
