From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 22 Aug 2017 19:08:29 +0200
Subject: [PATCH net-next v2 09/10] arm64: dts: marvell: add a reference to the
 sysctrl syscon in the ppv2 node
In-Reply-To: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
References: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
Message-ID: <20170822170830.32413-10-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The network driver on Marvell SoC (7k/8k) needs to access some registers
in the system controller to configure its ports at runtime. This patch
adds a phandle reference to the syscon system controller node in the
ppv2 node.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Tested-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 1 +
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 4c68605675a8..18299e164cb7 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -65,6 +65,7 @@
 				reg = <0x0 0x100000>, <0x129000 0xb000>;
 				clocks = <&cpm_clk 1 3>, <&cpm_clk 1 9>, <&cpm_clk 1 5>;
 				clock-names = "pp_clk", "gop_clk", "mg_clk";
+				marvell,system-controller = <&cpm_syscon0>;
 				status = "disabled";
 				dma-coherent;
 
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 923f354b02f0..5ae8fa575859 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -72,6 +72,7 @@
 				reg = <0x0 0x100000>, <0x129000 0xb000>;
 				clocks = <&cps_clk 1 3>, <&cps_clk 1 9>, <&cps_clk 1 5>;
 				clock-names = "pp_clk", "gop_clk", "mg_clk";
+				marvell,system-controller = <&cps_syscon0>;
 				status = "disabled";
 				dma-coherent;
 
-- 
2.13.5
