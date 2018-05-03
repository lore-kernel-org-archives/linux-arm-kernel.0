From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Thu,  3 May 2018 11:35:51 +0200
Subject: [PATCH v7 6/6] gnss: add w2sg0004 to Kconfig
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
Message-ID: <7035d90fb71c4bc9d2e7c1090b77bdd6bdfd9871.1525340143.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow to configure for w2sg0004 driver.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gnss/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index 6abc88514512..ccc128bd0a3f 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -40,4 +40,14 @@ config GNSS_UBX_SERIAL
 
 	  If unsure, say N.
 
+config GNSS_W2SG0004
+	tristate "W2SG00x4 power on/off driver"
+	depends on GPIOLIB && SERIAL_DEV_BUS
+	help
+	  Enable on/off control of W2SG00x4 GPS module connected
+	  to some SoC UART to allow powering up/down if the /dev/gnss
+	  is opened/closed.
+
+	  It also provides a "rfkill gps" name to control the LNA power.
+
 endif # GNSS
-- 
2.12.2
