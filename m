From: B48286@freescale.com (Zhiqiang Hou)
Date: Wed, 14 Oct 2015 19:34:53 +0800
Subject: [PATCH V3 1/6] i2c: Add i2c support to Freescale Layerscape platforms
In-Reply-To: <1444822498-16477-1-git-send-email-B48286@freescale.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
Message-ID: <1444822498-16477-2-git-send-email-B48286@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@freescale.com>

Modify the I2C_IMX config to support to Layerscape platforms.

Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
V3:
 - No change.

 drivers/i2c/busses/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 08b8617..14147ec 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -582,10 +582,10 @@ config I2C_IMG
 
 config I2C_IMX
 	tristate "IMX I2C interface"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || ARCH_LAYERSCAPE
 	help
 	  Say Y here if you want to use the IIC bus controller on
-	  the Freescale i.MX/MXC processors.
+	  the Freescale i.MX/MXC or Layerscape processors.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-imx.
-- 
2.1.0.27.g96db324
