From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 17:55:24 +0200
Subject: [PATCH 6/7] arm64: dts: marvell: remove *-clock-output-names on cp110
In-Reply-To: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
References: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
Message-ID: <3f801d2c23a60a3b87c284c450f8cc423579b8a7.1495208533.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The *-clock-output-names of the cp110-system-controller0 node are not
used anymore, so remove them.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 13 +-------------
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 13 +-------------
 2 files changed, 26 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 59259270964c..a0f57a8e5dcb 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -101,19 +101,6 @@
 					     "syscon";
 				reg = <0x440000 0x1000>;
 				#clock-cells = <2>;
-				core-clock-output-names =
-					"cpm-apll", "cpm-ppv2-core", "cpm-eip",
-					"cpm-core", "cpm-nand-core";
-				gate-clock-output-names =
-					"cpm-audio", "cpm-communit", "cpm-nand",
-					"cpm-ppv2", "cpm-sdio", "cpm-mg-domain",
-					"cpm-mg-core", "cpm-xor1", "cpm-xor0",
-					"cpm-gop-dp", "none", "cpm-pcie_x10",
-					"cpm-pcie_x11", "cpm-pcie_x4", "cpm-pcie-xor",
-					"cpm-sata", "cpm-sata-usb", "cpm-main",
-					"cpm-gop", "none", "none",
-					"cpm-slow-io", "cpm-usb3h0", "cpm-usb3h1",
-					"cpm-usb3dev", "cpm-eip150", "cpm-eip197";
 			};
 
 			cpm_rtc: rtc at 284000 {
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 046d3fe53cda..9584bc8d8b3f 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -108,19 +108,6 @@
 					     "syscon";
 				reg = <0x440000 0x1000>;
 				#clock-cells = <2>;
-				core-clock-output-names =
-					"cps-apll", "cps-ppv2-core", "cps-eip",
-					"cps-core", "cps-nand-core";
-				gate-clock-output-names =
-					"cps-audio", "cps-communit", "cps-nand",
-					"cps-ppv2", "cps-sdio", "cps-mg-domain",
-					"cps-mg-core", "cps-xor1", "cps-xor0",
-					"cps-gop-dp", "none", "cps-pcie_x10",
-					"cps-pcie_x11", "cps-pcie_x4", "cps-pcie-xor",
-					"cps-sata", "cps-sata-usb", "cps-main",
-					"cps-gop", "none", "none",
-					"cps-slow-io", "cps-usb3h0", "cps-usb3h1",
-					"cps-usb3dev", "cps-eip150", "cps-eip197";
 			};
 
 			cps_sata0: sata at 540000 {
-- 
git-series 0.9.1
