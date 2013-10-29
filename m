From: denis@eukrea.com (Denis Carikli)
Date: Tue, 29 Oct 2013 16:50:56 +0100
Subject: [PATCHv8][ 3/6] video: Kconfig: Allow more broad selection of the
 imxfb framebuffer driver.
In-Reply-To: <1383061860-25035-1-git-send-email-denis@eukrea.com>
References: <1383061860-25035-1-git-send-email-denis@eukrea.com>
Message-ID: <1383061860-25035-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without that patch, a user can't select the imxfb driver when the i.MX25 and/or
  the i.MX27 device tree board are selected and that no boards that selects
  IMX_HAVE_PLATFORM_IMX_FB are compiled in.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev at vger.kernel.org
Cc: Eric B?nard <eric@eukrea.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v7->v8:
- Added ACKs.
- Add some CC(Framebuffer maintainers and mailing lists).
- Improved commit message summary.
---
 drivers/video/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4f2e1b3..22adaee 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -363,7 +363,7 @@ config FB_SA1100
 
 config FB_IMX
 	tristate "Freescale i.MX1/21/25/27 LCD support"
-	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
+	depends on FB && ARCH_MXC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.7.9.5
