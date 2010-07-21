From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 21 Jul 2010 23:59:55 +0200
Subject: [PATCH 5/5] pcm043: register flexcan device
In-Reply-To: <1279749595-21596-1-git-send-email-mkl@pengutronix.de>
References: <1279749595-21596-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1279749595-21596-6-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-mx3/mach-pcm043.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index b92f624..73d33af 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -143,6 +143,7 @@ static struct platform_device *devices[] __initdata = {
 	&pcm043_flash,
 	&mxc_fec_device,
 	&imx_wdt_device0,
+	&mxc_can_device1,
 };
 
 static struct pad_desc pcm043_pads[] = {
@@ -214,6 +215,9 @@ static struct pad_desc pcm043_pads[] = {
 	MX35_PAD_STXD4__AUDMUX_AUD4_TXD,
 	MX35_PAD_SRXD4__AUDMUX_AUD4_RXD,
 	MX35_PAD_SCK4__AUDMUX_AUD4_TXC,
+	/* CAN2 */
+	MX35_PAD_TX5_RX0__CAN2_TXCAN,
+	MX35_PAD_TX4_RX1__CAN2_RXCAN,
 };
 
 #define AC97_GPIO_TXFS	(1 * 32 + 31)
-- 
1.7.1
