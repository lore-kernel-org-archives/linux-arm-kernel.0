From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  7 Mar 2011 12:18:55 +0200
Subject: [PATCH] ARM: imx/mx25: fix (again) spi device registration typo
Message-ID: <261dca45230fd96c27c3d8c1cdeefa35a21ff414.1299493026.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This typo was fixed in 46e3f30 (mx25: fix spi device registration typo), but a
the merge at 0e44e059 (Merge commit 'v2.6.37-rc4' into imx-for-2.6.38) resolved
the merge conflict wrongly.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-imx/devices-imx25.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx25.h b/arch/arm/mach-imx/devices-imx25.h
index bde33ca..d1ea79a 100644
--- a/arch/arm/mach-imx/devices-imx25.h
+++ b/arch/arm/mach-imx/devices-imx25.h
@@ -81,7 +81,7 @@ imx25_sdhci_esdhc_imx_data[] __initconst;
 
 extern const struct imx_spi_imx_data imx25_cspi_data[] __initconst;
 #define imx25_add_spi_imx(id, pdata)	\
-	imx_add_spi_imx(&imx25_spi_imx_data[id], pdata)
+	imx_add_spi_imx(&imx25_cspi_data[id], pdata)
 #define imx25_add_spi_imx0(pdata)	imx25_add_spi_imx(0, pdata)
 #define imx25_add_spi_imx1(pdata)	imx25_add_spi_imx(1, pdata)
 #define imx25_add_spi_imx2(pdata)	imx25_add_spi_imx(2, pdata)
-- 
1.7.2.3
