From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 10 May 2014 07:56:54 -0500
Subject: [PATCH v2 2/7] ARM: sun6i: Add the USB clocks to the DTSI.
In-Reply-To: <1399726619-30150-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399726619-30150-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1399726619-30150-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB clocks of the A31 seems to be parented to the 24MHz oscillator, and
handle the clocks for the USB phys and OHCI devices.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index eec1afa257a5..13aa56ed5858 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -269,6 +269,17 @@
 			clocks = <&osc24M>, <&pll6>;
 			clock-output-names = "spi3";
 		};
+
+		usb_clk: clk at 01c200cc {
+			#clock-cells = <1>;
+		        #reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-usb-clk";
+			reg = <0x01c200cc 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "usb_phy0", "usb_phy1", "usb_phy2",
+					     "usb_ohci0", "usb_ohci1",
+					     "usb_ohci2";
+		};
 	};
 
 	soc at 01c00000 {
-- 
1.9.1
