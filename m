From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  7 Mar 2011 15:19:11 +0200
Subject: [PATCH] ARM: imx/mx25: dynamically allocate pwm devices
Message-ID: <5cdc9853c72e9225a6d087ab6fc487903a337f8d.1299503913.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-imx/devices-imx25.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx25.h b/arch/arm/mach-imx/devices-imx25.h
index d1ea79a..b591d72 100644
--- a/arch/arm/mach-imx/devices-imx25.h
+++ b/arch/arm/mach-imx/devices-imx25.h
@@ -85,3 +85,7 @@ extern const struct imx_spi_imx_data imx25_cspi_data[] __initconst;
 #define imx25_add_spi_imx0(pdata)	imx25_add_spi_imx(0, pdata)
 #define imx25_add_spi_imx1(pdata)	imx25_add_spi_imx(1, pdata)
 #define imx25_add_spi_imx2(pdata)	imx25_add_spi_imx(2, pdata)
+
+extern struct imx_mxc_pwm_data imx25_mxc_pwm_data[] __initconst;
+#define imx25_add_mxc_pwm(id)	\
+	imx_add_mxc_pwm(&imx25_mxc_pwm_data[id])
-- 
1.7.2.3
