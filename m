From: digetx@gmail.com (Dmitry Osipenko)
Date: Sun, 18 Feb 2018 20:01:45 +0300
Subject: [PATCH v1 1/2] ARM: dts: tegra30: Add IRAM node
In-Reply-To: <cover.1518973069.git.digetx@gmail.com>
References: <cover.1518973069.git.digetx@gmail.com>
Message-ID: <082616811bfc669ec92e74c26d23cc73ac8e77a9.1518973069.git.digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRAM is a static RAM that consists of four contiguous 64 KiB blocks,
it is currently used to store CPU resume code, utilized by the video
decoder engine and could be used as a general-purpose fast memory.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index c3e9f1e847db..1fb0c421a9d8 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -11,6 +11,14 @@
 	compatible = "nvidia,tegra30";
 	interrupt-parent = <&lic>;
 
+	iram at 40000000 {
+		compatible = "mmio-sram";
+		reg = <0x40000000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x40000000 0x40000>;
+	};
+
 	pcie at 3000 {
 		compatible = "nvidia,tegra30-pcie";
 		device_type = "pci";
-- 
2.16.1
