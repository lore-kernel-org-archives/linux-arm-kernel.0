From: marex@denx.de (Marek Vasut)
Date: Fri, 11 Jan 2013 00:43:51 +0100
Subject: [PATCH 2/2] iio: mxs: Enable touchscreen on m28evk
In-Reply-To: <1357861431-8978-1-git-send-email-marex@denx.de>
References: <1357861431-8978-1-git-send-email-marex@denx.de>
Message-ID: <1357861431-8978-2-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds necessary DT properties to m28evk to enable touchscreen
in the LRADC block. The M28EVK is shipped with 4-wire resistive touchscreen.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-m28evk.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index c718f91..712d99a 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -213,6 +213,7 @@
 
 			lradc at 80050000 {
 				status = "okay";
+				fsl,lradc-touchscreen-wires = <4>;
 			};
 
 			duart: serial at 80074000 {
-- 
1.7.10.4
