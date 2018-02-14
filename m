From: embed3d@gmail.com (Philipp Rossak)
Date: Wed, 14 Feb 2018 15:10:24 +0100
Subject: [PATCH v2 1/2] arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
In-Reply-To: <20180214141025.22171-1-embed3d@gmail.com>
References: <20180214141025.22171-1-embed3d@gmail.com>
Message-ID: <20180214141025.22171-2-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eldoin is supplied from the dcdc1 regulator. The N_VBUSEN pin is
connected to an external power regulator (SY6280AAC).
With this commit we update the pmic binding properties to support
those features.

Fixes: 7daa21370075 ("ARM: dts: sunxi: Add regulators for Sinovoip
BPI-M2")

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 51e6f1d21c32..fb34f32502cf 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -163,6 +163,8 @@
 		reg = <0x68>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
 	};
 };
 
-- 
2.11.0
