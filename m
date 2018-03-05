From: eric@anholt.net (Eric Anholt)
Date: Mon,  5 Mar 2018 12:28:05 -0800
Subject: [PATCH 4/5] ARM: dts: bcm2835: Add VCHI node to the Raspberry Pi
 boards.
In-Reply-To: <20180305202806.21219-1-eric@anholt.net>
References: <20180305202806.21219-1-eric@anholt.net>
Message-ID: <20180305202806.21219-5-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VCHI firmware communication channel operates in parallel with our
other mailbox-based channel.  This is the communication channel that
exposes the firmware's media decode/encode and ISP interfaces.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e36c392a2b8f..c128bc6a1435 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -27,6 +27,13 @@
 			firmware = <&firmware>;
 			#power-domain-cells = <1>;
 		};
+
+		vchi at 7e00b840 {
+			compatible = "brcm,bcm2835-vchiq";
+			reg = <0x7e00b840 0xf>;
+			interrupts = <0 2>;
+			firmware = <&firmware>;
+		};
 	};
 };
 
-- 
2.16.2
