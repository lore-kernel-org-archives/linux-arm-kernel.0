From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 21 Nov 2013 02:21:26 +0800
Subject: [PATCH 3/3] ARM: EXYNOS: Constify clksrc immutable register restore
 tables
In-Reply-To: <1384971686-7208-1-git-send-email-djkurtz@chromium.org>
References: <1384971686-7208-1-git-send-email-djkurtz@chromium.org>
Message-ID: <1384971686-7208-3-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clksrc tables are constant, they are not used to store register values
at suspend.

size arch/arm/mach-exynos/pm.o
   text	   data	    bss
   1591	    212	     12	   // Before
   1671	    132	     12	   // After

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 arch/arm/mach-exynos/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index c679db5..7fb0f13 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -36,7 +36,7 @@
 
 #include "common.h"
 
-static struct sleep_save exynos4_set_clksrc[] = {
+static const struct sleep_save exynos4_set_clksrc[] = {
 	{ .reg = EXYNOS4_CLKSRC_MASK_TOP		, .val = 0x00000001, },
 	{ .reg = EXYNOS4_CLKSRC_MASK_CAM		, .val = 0x11111111, },
 	{ .reg = EXYNOS4_CLKSRC_MASK_TV			, .val = 0x00000111, },
@@ -48,7 +48,7 @@ static struct sleep_save exynos4_set_clksrc[] = {
 	{ .reg = EXYNOS4_CLKSRC_MASK_DMC		, .val = 0x00010000, },
 };
 
-static struct sleep_save exynos4210_set_clksrc[] = {
+static const struct sleep_save exynos4210_set_clksrc[] = {
 	{ .reg = EXYNOS4210_CLKSRC_MASK_LCD1		, .val = 0x00001111, },
 };
 
-- 
1.8.4.1
