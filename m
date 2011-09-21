From: hatim.rv@samsung.com (Hatim Ali)
Date: Wed, 21 Sep 2011 11:14:20 +0530
Subject: [RESEND PATCH 3/3] s5p-tv: Add PM_RUNTIME dependency
In-Reply-To: <1316583860-32510-1-git-send-email-hatim.rv@samsung.com>
References: <1316583860-32510-1-git-send-email-hatim.rv@samsung.com>
Message-ID: <1316583860-32510-4-git-send-email-hatim.rv@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TVOUT driver requires PM_RUNTIME support for proper clock
enabling.

Signed-off-by: Hatim Ali <hatim.rv@samsung.com>
---
 drivers/media/video/s5p-tv/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/s5p-tv/Kconfig b/drivers/media/video/s5p-tv/Kconfig
index 9c37dee..f2a0977 100644
--- a/drivers/media/video/s5p-tv/Kconfig
+++ b/drivers/media/video/s5p-tv/Kconfig
@@ -8,7 +8,7 @@
 
 config VIDEO_SAMSUNG_S5P_TV
 	bool "Samsung TV driver for S5P platform (experimental)"
-	depends on PLAT_S5P
+	depends on PLAT_S5P && PM_RUNTIME
 	depends on EXPERIMENTAL
 	default n
 	---help---
-- 
1.7.2.3
