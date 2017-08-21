From: s-anna@ti.com (Suman Anna)
Date: Mon, 21 Aug 2017 18:51:58 -0500
Subject: [PATCH 5/5] ARM: dts: am571x-idk: Enable relevant IPU and DSP MMU
 nodes
In-Reply-To: <20170821235158.4968-1-s-anna@ti.com>
References: <20170821235158.4968-1-s-anna@ti.com>
Message-ID: <20170821235158.4968-6-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMU nodes for the remote processors IPU1, IPU2 and DSP1
have all been enabled. All these nodes are relevant and valid
for the AM571x IDK board. DSP2 MMU nodes are not present on
AM571x SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index debf9464403e..ea9f695e1282 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -91,6 +91,22 @@
 	};
 };
 
+&mmu0_dsp1 {
+	status = "okay";
+};
+
+&mmu1_dsp1 {
+	status = "okay";
+};
+
+&mmu_ipu1 {
+	status = "okay";
+};
+
+&mmu_ipu2 {
+	status = "okay";
+};
+
 &pcie1_rc {
 	status = "okay";
 	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
-- 
2.13.1
