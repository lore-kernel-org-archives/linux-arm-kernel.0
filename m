From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Aug 2017 10:19:50 +0200
Subject: [PATCH 5/9] ARM: dts: koelsch: Add CEC clock for HDMI transmitter
In-Reply-To: <cover.1502962873.git.horms+renesas@verge.net.au>
References: <cover.1502962873.git.horms+renesas@verge.net.au>
Message-ID: <02a5ab18d366223893d634b0992f6434300bee32.1502962873.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hans Verkuil <hans.verkuil@cisco.com>

The adv7511 on the Koelsch board has a 12 MHz fixed clock
for the CEC block. Specify this in the dts to enable CEC support.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index dc8ed02de707..0ce0b278e1cb 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -642,11 +642,19 @@
 		};
 	};
 
+	cec_clock: cec-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12000000>;
+	};
+
 	hdmi at 39 {
 		compatible = "adi,adv7511w";
 		reg = <0x39>;
 		interrupt-parent = <&gpio3>;
 		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&cec_clock>;
+		clock-names = "cec";
 
 		adi,input-depth = <8>;
 		adi,input-colorspace = "rgb";
-- 
2.1.4
