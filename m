From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Jan 2017 10:09:21 +0100
Subject: [PATCH 1/4] ARM: dts: imx7s-warp: Fix watchdog pinmux
In-Reply-To: <20170119090924.19636-1-s.hauer@pengutronix.de>
References: <20170119090924.19636-1-s.hauer@pengutronix.de>
Message-ID: <20170119090924.19636-2-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog pin is controlled by the iomuxc_lpsr, not the regular
iomux, so move it there.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx7s-warp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 0345267f3390..cbb5bc16e713 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -437,7 +437,9 @@
 			MX7D_PAD_SD3_RESET_B__SD3_RESET_B	0x1b
 		>;
 	};
+};
 
+&iomuxc_lpsr {
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B	0x74
-- 
2.11.0
