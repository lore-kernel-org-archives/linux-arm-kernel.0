From: s-anna@ti.com (Suman Anna)
Date: Mon, 21 Aug 2017 18:51:55 -0500
Subject: [PATCH 2/5] ARM: dts: dra72-evm-common: Enable relevant IPU and DSP
 MMU nodes
In-Reply-To: <20170821235158.4968-1-s-anna@ti.com>
References: <20170821235158.4968-1-s-anna@ti.com>
Message-ID: <20170821235158.4968-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMU nodes for the remote processors IPU1, IPU2 and DSP1 have
all been enabled. All these nodes are relevant and valid for both
the DRA72x EVM variants and the DRA71 EVM, so are added in the common
dts file. DSP2 MMU nodes are not present on DRA72x/DRA71x SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra72-evm-common.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 2e485a13dfd7..a72bcfd032d3 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -564,6 +564,22 @@
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
 };
-- 
2.13.1
