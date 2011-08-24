From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 24 Aug 2011 12:04:14 -0300
Subject: [PATCH] ARM: imx: Define functions for registering PATA
Message-ID: <1314198254-6463-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define functions for registering PATA on MX27/MX31/MX35/MX53.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/devices-imx27.h |    4 ++++
 arch/arm/mach-imx/devices-imx31.h |    4 ++++
 arch/arm/mach-imx/devices-imx35.h |    4 ++++
 arch/arm/mach-mx5/devices-imx53.h |    4 ++++
 4 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 7f97a3c..2f727d7 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -76,3 +76,7 @@ extern const struct imx_spi_imx_data imx27_cspi_data[];
 #define imx27_add_spi_imx0(pdata)	imx27_add_cspi(0, pdata)
 #define imx27_add_spi_imx1(pdata)	imx27_add_cspi(1, pdata)
 #define imx27_add_spi_imx2(pdata)	imx27_add_cspi(2, pdata)
+
+extern const struct imx_pata_imx_data imx27_pata_imx_data;
+#define imx27_add_pata_imx() \
+	imx_add_pata_imx(&imx27_pata_imx_data)
diff --git a/arch/arm/mach-imx/devices-imx31.h b/arch/arm/mach-imx/devices-imx31.h
index dbe940d..488e241 100644
--- a/arch/arm/mach-imx/devices-imx31.h
+++ b/arch/arm/mach-imx/devices-imx31.h
@@ -78,3 +78,7 @@ extern const struct imx_spi_imx_data imx31_cspi_data[];
 #define imx31_add_spi_imx0(pdata)	imx31_add_cspi(0, pdata)
 #define imx31_add_spi_imx1(pdata)	imx31_add_cspi(1, pdata)
 #define imx31_add_spi_imx2(pdata)	imx31_add_cspi(2, pdata)
+
+extern const struct imx_pata_imx_data imx31_pata_imx_data;
+#define imx31_add_pata_imx() \
+	imx_add_pata_imx(&imx31_pata_imx_data)
diff --git a/arch/arm/mach-imx/devices-imx35.h b/arch/arm/mach-imx/devices-imx35.h
index 234cbd3..7b99ef0 100644
--- a/arch/arm/mach-imx/devices-imx35.h
+++ b/arch/arm/mach-imx/devices-imx35.h
@@ -81,3 +81,7 @@ extern const struct imx_spi_imx_data imx35_cspi_data[];
 	imx_add_spi_imx(&imx35_cspi_data[id], pdata)
 #define imx35_add_spi_imx0(pdata)	imx35_add_cspi(0, pdata)
 #define imx35_add_spi_imx1(pdata)	imx35_add_cspi(1, pdata)
+
+extern const struct imx_pata_imx_data imx35_pata_imx_data;
+#define imx35_add_pata_imx() \
+	imx_add_pata_imx(&imx35_pata_imx_data)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index c27fe8b..7ca5d0c 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -40,3 +40,7 @@ extern const struct imx_imx_ssi_data imx53_imx_ssi_data[];
 extern const struct imx_imx_keypad_data imx53_imx_keypad_data;
 #define imx53_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx53_imx_keypad_data, pdata)
+
+extern const struct imx_pata_imx_data imx53_pata_imx_data;
+#define imx53_add_pata_imx() \
+	imx_add_pata_imx(&imx53_pata_imx_data)
-- 
1.6.0.4
