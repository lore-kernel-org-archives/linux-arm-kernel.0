From: stefan@agner.ch (Stefan Agner)
Date: Tue, 26 Jun 2018 16:52:43 +0200
Subject: [PATCH 3/3] ARM: dts: imx6qdl-colibri: use pull-down on wake-up pin
In-Reply-To: <20180626145243.24880-1-stefan@agner.ch>
References: <20180626145243.24880-1-stefan@agner.ch>
Message-ID: <20180626145243.24880-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wake-up pin is pulled low with 100kOhm on the carrier board.
The current configuration of 100kOhm pull-up caused lots of
interrupts, especially during boot up. Make sure the pin is at a
reasonable level at startup by pulling it low on SoC side too.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 55c90c2fbf69..6e937ca20869 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -480,8 +480,7 @@
 
 	pinctrl_gpio_keys: gpiokeys {
 		fsl,pins = <
-			/* Power button */
-			MX6QDL_PAD_EIM_A16__GPIO2_IO22		0x1b0b0
+			MX6QDL_PAD_EIM_A16__GPIO2_IO22		0x130b0
 		>;
 	};
 
-- 
2.18.0
