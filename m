From: javier.martin@vista-silicon.com (Javier Martin)
Date: Tue, 28 Feb 2012 17:31:49 +0100
Subject: [PATCH v2 2/4] i.MX27: visstrim_m10: Register I2C devices after I2C
 busses have been added.
In-Reply-To: <1330446711-6970-1-git-send-email-javier.martin@vista-silicon.com>
References: <1330446711-6970-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <1330446711-6970-3-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index c2766ae..1c26c6d 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -254,10 +254,11 @@ static void __init visstrim_m10_board_init(void)
 	imx27_add_imx_ssi(0, &visstrim_m10_ssi_pdata);
 	imx27_add_imx_uart0(&uart_pdata);
 
-	i2c_register_board_info(0, visstrim_m10_i2c_devices,
-				ARRAY_SIZE(visstrim_m10_i2c_devices));
 	imx27_add_imx_i2c(0, &visstrim_m10_i2c_data);
 	imx27_add_imx_i2c(1, &visstrim_m10_i2c_data);
+	i2c_register_board_info(0, visstrim_m10_i2c_devices,
+				ARRAY_SIZE(visstrim_m10_i2c_devices));
+
 	imx27_add_mxc_mmc(0, &visstrim_m10_sdhc_pdata);
 	imx27_add_mxc_ehci_otg(&visstrim_m10_usbotg_pdata);
 	imx27_add_fec(NULL);
-- 
1.7.0.4
