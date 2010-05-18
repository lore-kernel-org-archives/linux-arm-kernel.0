From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 11:54:01 +0100
Subject: [PATCH 1/5] s3c-fb: Change to depending on CONFIG_S3C_FB_DEV
In-Reply-To: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
References: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274180045-14645-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by Marek Szyprowski, we should make the driver depend on
the configuration currently being used to build the platform device
into the kernel.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6e16244..a358989 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1914,7 +1914,7 @@ config FB_TMIO_ACCELL
 
 config FB_S3C
 	tristate "Samsung S3C framebuffer support"
-	depends on FB && ARCH_S3C64XX
+	depends on FB && S3C_DEV_FB
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.6.3.3
