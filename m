From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 19 Dec 2017 15:01:29 +0530
Subject: [PATCH 3/7] ARM: dts: DRA72x: Use PCIe compatible specific to dra72
In-Reply-To: <20171219093133.16565-1-kishon@ti.com>
References: <20171219093133.16565-1-kishon@ti.com>
Message-ID: <20171219093133.16565-4-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dra72 specific compatible string for PCIe while preserving
the older compatible.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra72x.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
index 67107605fb4c..2dafad834d3d 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -50,3 +50,15 @@
 		status = "disabled";
 	};
 };
+
+&pcie1_rc {
+	compatible = "ti,dra726-pcie-rc", "ti,dra7-pcie";
+};
+
+&pcie1_ep {
+	compatible = "ti,dra726-pcie-ep", "ti,dra7-pcie-ep";
+};
+
+&pcie2_rc {
+	compatible = "ti,dra726-pcie-rc", "ti,dra7-pcie";
+};
-- 
2.11.0
