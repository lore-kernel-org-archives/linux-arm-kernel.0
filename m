From: vitalya@ti.com (Vitaly Andrianov)
Date: Thu, 24 May 2018 09:12:16 -0400
Subject: [PATCH 1/3] ARM: dts: k2hk: add dts node for k2hk hw_rng driver
In-Reply-To: <1527167538-29837-1-git-send-email-vitalya@ti.com>
References: <1527167538-29837-1-git-send-email-vitalya@ti.com>
Message-ID: <1527167538-29837-2-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dts node for k2hk hw_random generator driver

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
[t-kristo at ti.com: added missing addresses from node identifiers]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi b/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
index b88c068..e203145 100644
--- a/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
@@ -228,3 +228,23 @@ netcp: netcp at 2000000 {
 		};
 	};
 };
+
+sa_subsys: subsys at 20c0000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0 0x20c0000 0x40000>;
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
