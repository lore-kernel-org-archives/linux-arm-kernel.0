From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 25 Jan 2013 16:41:48 +0530
Subject: [PATCH v2 2/6] ARM: dts: omap5: Add ocp2scp data
In-Reply-To: <1359112312-6918-1-git-send-email-kishon@ti.com>
References: <1359112312-6918-1-git-send-email-kishon@ti.com>
Message-ID: <1359112312-6918-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ocp2scp data node in omap5 device tree file. The information for
the node added here can be found @
Documentation/devicetree/bindings/bus/omap-ocp2scp.txt

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index edc7464..d149330 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -512,5 +512,13 @@
 			reg-names = "control_dev_conf", "phy_power_usb";
 			ti,type = <2>;
 		};
+
+		ocp2scp {
+			compatible = "ti,omap-ocp2scp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			ti,hwmods = "ocp2scp1";
+		};
 	};
 };
-- 
1.7.9.5
