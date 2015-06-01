From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  1 Jun 2015 20:23:28 +0200
Subject: [PATCH 2/2] ARM: dts: sun8i: Add usb_clk node for a23/a33
In-Reply-To: <1433183008-13086-1-git-send-email-hdegoede@redhat.com>
References: <1433183008-13086-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433183008-13086-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an usb_clk node for a23/a33.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index c73d1d1..44dd7155 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -248,6 +248,16 @@
 					     "mmc2_output",
 					     "mmc2_sample";
 		};
+
+		usb_clk: clk at 01c200cc {
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			compatible = "allwinner,sun8i-a23-usb-clk";
+			reg = <0x01c200cc 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "usb_phy0", "usb_phy1", "hsic",
+					     "hsic_12m", "usb_ohci0";
+		};
 	};
 
 	soc at 01c00000 {
-- 
2.4.2
