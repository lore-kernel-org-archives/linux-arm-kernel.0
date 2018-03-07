From: eric@anholt.net (Eric Anholt)
Date: Wed,  7 Mar 2018 10:57:14 -0800
Subject: [PATCH v2 4/6] ARM: dts: bcm2835: Add VCHIQ node to the Raspberry Pi
 boards.
In-Reply-To: <20180307185716.17449-1-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net>
Message-ID: <20180307185716.17449-4-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VCHIQ firmware communication channel operates in parallel with our
other mailbox-based channel.  This is the communication channel that
exposes the firmware's media decode/encode and ISP interfaces.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: dropped firmware property, added cache-line-size.

 arch/arm/boot/dts/bcm2835-rpi.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e36c392a2b8f..ba6dd25ac93f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -27,6 +27,17 @@
 			firmware = <&firmware>;
 			#power-domain-cells = <1>;
 		};
+
+		vchiq at 7e00b840 {
+			compatible = "brcm,bcm2835-vchiq";
+			reg = <0x7e00b840 0xf>;
+			interrupts = <0 2>;
+			/* The VPU firmware will override this DT property
+			 * (if present) with the L2 cache line size value it
+			 * wants to use.
+			 */
+			cache-line-size = <32>;
+		};
 	};
 };
 
-- 
2.16.2
