From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  9 Dec 2014 17:13:36 +0100
Subject: [PATCH 2/2] ARM: dts: imx6qdl: remove USBOH3 clock from usbmisc,
 it is clocked by IPG
In-Reply-To: <1418141616-29671-1-git-send-email-p.zabel@pengutronix.de>
References: <1418141616-29671-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1418141616-29671-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6Q, the USBMISC registers are clocked by the IPG clock,
so there is no need to enable USBOH3 for the USBMISC driver.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 28e6878..ff3edb0 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -896,7 +896,6 @@
 				#index-cells = <1>;
 				compatible = "fsl,imx6q-usbmisc";
 				reg = <0x02184800 0x200>;
-				clocks = <&clks IMX6QDL_CLK_USBOH3>;
 			};
 
 			fec: ethernet at 02188000 {
-- 
2.1.3
