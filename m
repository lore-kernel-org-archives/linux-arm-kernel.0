From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Wed, 23 Feb 2011 16:58:39 +0000
Subject: [PATCH 4/4] MX1: Add registration functions for SPI.
In-Reply-To: <1298480319-72386-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1298480319-72386-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
	<1298480319-72386-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
	<1298480319-72386-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1298480319-72386-4-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/mach-imx/devices-imx1.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx1.h b/arch/arm/mach-imx/devices-imx1.h
index 8197948..fd26715 100644
--- a/arch/arm/mach-imx/devices-imx1.h
+++ b/arch/arm/mach-imx/devices-imx1.h
@@ -18,3 +18,10 @@ extern const struct imx_imx_uart_3irq_data imx1_imx_uart_data[] __initconst;
 	imx_add_imx_uart_3irq(&imx1_imx_uart_data[id], pdata)
 #define imx1_add_imx_uart0(pdata)	imx1_add_imx_uart(0, pdata)
 #define imx1_add_imx_uart1(pdata)	imx1_add_imx_uart(1, pdata)
+
+extern const struct imx_spi_imx_data imx1_cspi_data[] __initconst;
+#define imx1_add_cspi(id, pdata)   \
+	imx_add_spi_imx(&imx1_cspi_data[id], pdata)
+
+#define imx1_add_spi_imx0(pdata) imx1_add_cspi(0, pdata)
+#define imx1_add_spi_imx1(pdata) imx1_add_cspi(1, pdata)
-- 
1.7.3.4
