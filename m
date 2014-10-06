From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 06 Oct 2014 11:10:26 +0200
Subject: [PATCH 3/4] [media] Remove optional dependency on PLAT_S5P
Message-ID: <1412586626.4054.42.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d78c16ccde96 ("ARM: SAMSUNG: Remove remaining legacy code")
removed the Kconfig symbol PLAT_S5P. Remove an optional dependency on
that symbol from this Kconfig file too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 drivers/media/platform/s5p-tv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-tv/Kconfig b/drivers/media/platform/s5p-tv/Kconfig
index a9d56f8936b4..3d11fea5cc92 100644
--- a/drivers/media/platform/s5p-tv/Kconfig
+++ b/drivers/media/platform/s5p-tv/Kconfig
@@ -9,7 +9,7 @@
 config VIDEO_SAMSUNG_S5P_TV
 	bool "Samsung TV driver for S5P platform"
 	depends on PM_RUNTIME
-	depends on PLAT_S5P || ARCH_EXYNOS || COMPILE_TEST
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	default n
 	---help---
 	  Say Y here to enable selecting the TV output devices for
-- 
1.9.3
