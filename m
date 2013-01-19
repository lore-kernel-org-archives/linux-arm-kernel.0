From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 19 Jan 2013 08:15:37 -0200
Subject: [PATCH v2] video: Kconfig: Specify the SoCs that make use of FB_IMX
Message-ID: <1358590537-5013-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

FB_IMX is the framebuffer driver used by MX1, MX21, MX25 and MX27 processors.

Pass this information to the Kconfig text to make it clear.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Shawn,

Could you get this one also via your tree?

No response from the fb maintainer for months on this one.

Changes since v1:
- Add mx1/21 to the list.

 drivers/video/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0cff083..f0c53b2 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -364,7 +364,7 @@ config FB_SA1100
 	  Y here.
 
 config FB_IMX
-	tristate "Freescale i.MX LCD support"
+	tristate "Freescale i.MX1/21/25/27 LCD support"
 	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
-- 
1.7.9.5
