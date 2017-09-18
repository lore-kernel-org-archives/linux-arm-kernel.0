From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 18 Sep 2017 09:58:08 +0200
Subject: [PATCH 3/9] arm64: dts: marvell: extend the cp110 syscon register
 area length
In-Reply-To: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
References: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
Message-ID: <20170918075814.27405-4-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends on both cp110 the system register area length to
include some of the comphy registers as well.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 8263a8a504a8..faf7d4a497aa 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -143,7 +143,7 @@
 
 			cpm_syscon0: system-controller at 440000 {
 				compatible = "syscon", "simple-mfd";
-				reg = <0x440000 0x1000>;
+				reg = <0x440000 0x2000>;
 
 				cpm_clk: clock {
 					compatible = "marvell,cp110-clock";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index b71ee6c83668..02d6e2f1a7bf 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -143,7 +143,7 @@
 
 			cps_syscon0: system-controller at 440000 {
 				compatible = "syscon", "simple-mfd";
-				reg = <0x440000 0x1000>;
+				reg = <0x440000 0x2000>;
 
 				cps_clk: clock {
 					compatible = "marvell,cp110-clock";
-- 
2.13.5
