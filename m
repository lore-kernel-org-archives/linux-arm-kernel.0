From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Wed, 23 Feb 2011 16:58:36 +0000
Subject: [PATCH 1/4] MX1: Add data structure for SPI
Message-ID: <1298480319-72386-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/plat-mxc/devices/platform-spi_imx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index 013c85f..f4a60ab 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -21,6 +21,15 @@
 #define imx_spi_imx_data_entry(soc, type, devid, id, hwid, size)	\
 	[id] = imx_spi_imx_data_entry_single(soc, type, devid, id, hwid, size)
 
+#ifdef CONFIG_SOC_IMX1
+const struct imx_spi_imx_data imx1_cspi_data[] __initconst = {
+#define imx1_cspi_data_entry(_id, _hwid) \
+	imx_spi_imx_data_entry(MX1, CSPI, "imx1-cspi", _id, _hwid, SZ_4K)
+	imx1_cspi_data_entry(0, 1),
+	imx1_cspi_data_entry(1, 2),
+};
+#endif
+
 #ifdef CONFIG_SOC_IMX21
 const struct imx_spi_imx_data imx21_cspi_data[] __initconst = {
 #define imx21_cspi_data_entry(_id, _hwid)                            \
-- 
1.7.3.4
