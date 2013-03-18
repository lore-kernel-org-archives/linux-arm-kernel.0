From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:06:08 +0900
Subject: [PATCH 072/142] sh-pfc: r8a7779: Add USB0 and USB1 PENC pinmux support
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-73-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The USB0 and USB1 PENC functions were missing. Add them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 361b162..946572bc 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -429,7 +429,8 @@ enum {
 	A0_MARK, SD1_DAT3_MARK, MMC0_D3_MARK, FD3_MARK,
 	BS_MARK, SD1_DAT2_MARK, MMC0_D2_MARK, FD2_MARK,
 	ATADIR0_MARK, SDSELF_MARK, HCTS1_MARK, TX4_C_MARK,
-	USB_PENC2_MARK, SCK0_MARK, PWM1_MARK, PWMFSW0_MARK,
+	USB_PENC0_MARK, USB_PENC1_MARK, USB_PENC2_MARK,
+	SCK0_MARK, PWM1_MARK, PWMFSW0_MARK,
 	SCIF_CLK_MARK, TCLK0_C_MARK,
 
 	EX_CS0_MARK, RX3_C_IRDA_RX_C_MARK, MMC0_D6_MARK,
@@ -640,6 +641,9 @@ static const pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(A18_MARK, FN_A18),
 	PINMUX_DATA(A19_MARK, FN_A19),
 
+	PINMUX_DATA(USB_PENC0_MARK, FN_USB_PENC0),
+	PINMUX_DATA(USB_PENC1_MARK, FN_USB_PENC1),
+
 	PINMUX_IPSR_DATA(IP0_2_0, USB_PENC2),
 	PINMUX_IPSR_MODSEL_DATA(IP0_2_0, SCK0, SEL_SCIF0_0),
 	PINMUX_IPSR_DATA(IP0_2_0, PWM1),
-- 
1.7.10.4
