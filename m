From: vitalya@ti.com (Vitaly Andrianov)
Date: Thu, 24 May 2018 09:12:18 -0400
Subject: [PATCH 3/3] ARM: dts: k2e: add dts node for k2e hw_rng driver
In-Reply-To: <1527167538-29837-1-git-send-email-vitalya@ti.com>
References: <1527167538-29837-1-git-send-email-vitalya@ti.com>
Message-ID: <1527167538-29837-4-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dts node for k2e hw_random generator driver

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
index a17311c..1db17ec 100644
--- a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
@@ -225,3 +225,23 @@ netcp: netcp at 24000000 {
 		};
 	};
 };
+
+sa_subsys: subsys at 24080000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "simple-bus";
+	ranges = <0 0x24080000 0x40000>;
+
+	sa_config: subsys at 0 {
+		compatible = "syscon";
+		reg = <0x0 0x100>;
+	};
+
+	rng at 24000 {
+		compatible = "ti,keystone-rng";
+		reg = <0x24000 0x1000>;
+		ti,syscon-sa-cfg = <&sa_config>;
+		clocks = <&clksa>;
+		clock-names = "fck";
+	};
+};
-- 
2.7.4
