From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  5 Apr 2017 22:30:34 +0800
Subject: [PATCH 2/2] arm64: allwinner: a64: add pmu0 regs for USB PHY
In-Reply-To: <20170405143034.8868-1-icenowy@aosc.io>
References: <20170405143034.8868-1-icenowy@aosc.io>
Message-ID: <20170405143034.8868-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB PHY in A64 has a "pmu0" region, which controls the EHCI/OHCI
controller pair that can be connected to the PHY0.

Add the MMIO region for PHY node.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1c64ea2d23f9..0565779e66fa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -179,8 +179,10 @@
 		usbphy: phy at 01c19400 {
 			compatible = "allwinner,sun50i-a64-usb-phy";
 			reg = <0x01c19400 0x14>,
+			      <0x01c1a800 0x4>,
 			      <0x01c1b800 0x4>;
 			reg-names = "phy_ctrl",
+				    "pmu0",
 				    "pmu1";
 			clocks = <&ccu CLK_USB_PHY0>,
 				 <&ccu CLK_USB_PHY1>;
-- 
2.12.2
