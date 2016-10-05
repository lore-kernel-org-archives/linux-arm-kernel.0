From: paweljarosz3691@gmail.com (=?us-ascii?B?PT9VVEYtOD9xP1Bhd2U9QzU9ODI9MjBKYXJvc3o/PQ==?=)
Date: Wed, 5 Oct 2016 18:18:11 +0200
Subject: [PATCH v2] ARM: dts: rockchip: Reserve unusable memory region on
 rk3066
Message-ID: <20161005161811.GA17211@vaio-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason accessing memory region above 0x9F000000 freezes
system on rk3066. There is similiar bug on later rockchip soc (rk3288)
solved same way.

Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
---

Changes in v2:
- updated commit message.

 arch/arm/boot/dts/rk3066a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 0d0dae3..44c8956 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -93,6 +93,19 @@
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		/*
+		 * The rk3066 cannot use the memory area above 0x9F000000
+		 * for some unknown reason.
+		 */
+		unusable at 9F000000 {
+			reg = <0x9F000000 0x1000000>;
+		};
+	};
+
 	i2s0: i2s at 10118000 {
 		compatible = "rockchip,rk3066-i2s";
 		reg = <0x10118000 0x2000>;
-- 
2.7.4
