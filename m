From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 27 Jun 2018 21:37:13 -0700
Subject: [PATCH 2/2] ARM: dts: imx51-babbage: Make use of pinctrl_usbh1reg
In-Reply-To: <20180628043713.14425-1-andrew.smirnov@gmail.com>
References: <20180628043713.14425-1-andrew.smirnov@gmail.com>
Message-ID: <20180628043713.14425-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pinctrl_usbh1reg defines pinmux setting for reset GPIO used by
usbh1phy, but is not referenced by that node. Fix that.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-babbage.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 541c6e67ad1a..19d3f0127f91 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -177,6 +177,8 @@
 
 		usbh1phy: usbh1phy at 1 {
 			compatible = "usb-nop-xceiv";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbh1reg>;
 			reg = <1>;
 			clocks = <&clk_usb>;
 			clock-names = "main_clk";
-- 
2.17.1
