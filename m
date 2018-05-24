From: vitalya@ti.com (Vitaly Andrianov)
Date: Thu, 24 May 2018 09:12:17 -0400
Subject: [PATCH 2/3] ARM: dts: k2l: add dts node for k2l hw_rng driver
In-Reply-To: <1527167538-29837-1-git-send-email-vitalya@ti.com>
References: <1527167538-29837-1-git-send-email-vitalya@ti.com>
Message-ID: <1527167538-29837-3-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dts node for k2l hw_random generator driver

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
[t-kristo at ti.com: added missing addresses from node identifiers]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
index 9ec8422..a2e47ba 100644
--- a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
@@ -208,3 +208,23 @@ netcp: netcp at 26000000 {
 		};
 	};
 };
+
+sa_subsys: subsys at 26080000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "simple-bus";
+	ranges = <0 0x26080000 0x40000>;
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
