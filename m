From: eric@anholt.net (Eric Anholt)
Date: Fri,  9 Mar 2018 10:44:15 -0800
Subject: [PATCH v3 4/6] ARM: dts: bcm2835: Add VCHIQ node to the Raspberry Pi
 boards. (v3)
In-Reply-To: <20180309184417.23368-1-eric@anholt.net>
References: <20180309184417.23368-1-eric@anholt.net>
Message-ID: <20180309184417.23368-4-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VCHIQ firmware communication channel operates in parallel with our
other mailbox-based channel.  This is the communication channel that
exposes the firmware's media decode/encode and ISP interfaces.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com> (v2)
---

v2: dropped firmware property, added cache-line-size.
v3: dropped cache-line-size, s/vchi@/mailbox@/

 arch/arm/boot/dts/bcm2835-rpi.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e36c392a2b8f..593f58d4ac0f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -27,6 +27,12 @@
 			firmware = <&firmware>;
 			#power-domain-cells = <1>;
 		};
+
+		mailbox at 7e00b840 {
+			compatible = "brcm,bcm2835-vchiq";
+			reg = <0x7e00b840 0xf>;
+			interrupts = <0 2>;
+		};
 	};
 };
 
-- 
2.16.2
