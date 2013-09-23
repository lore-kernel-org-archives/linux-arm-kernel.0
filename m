From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 24 Sep 2013 00:16:30 +0800
Subject: [PATCH 1/9] arm/dts: sirf: add missed memcontrol-monitor node in
 prima2 and atlas6 dts
In-Reply-To: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
References: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1379952998-16393-2-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ye He <ye.he@csr.com>

memcontrol-monitor provides the ability of monitoring the memory bandwidth.

Signed-off-by: Ye He <ye.he@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 9 ++++++++-
 arch/arm/boot/dts/prima2.dtsi | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 8678e0c..2c55b27 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -75,10 +75,17 @@
 
 			memory-controller at 90000000 {
 				compatible = "sirf,prima2-memc";
-				reg = <0x90000000 0x10000>;
+				reg = <0x90000000 0x2000>;
 				interrupts = <27>;
 				clocks = <&clks 5>;
 			};
+
+			memc-monitor {
+				compatible = "sirf,prima2-memcmon";
+				reg = <0x90002000 0x200>;
+				interrupts = <4>;
+				clocks = <&clks 32>;
+			};
 		};
 
 		disp-iobg {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index bbeb623..41b2cde 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -86,10 +86,17 @@
 
 			memory-controller at 90000000 {
 				compatible = "sirf,prima2-memc";
-				reg = <0x90000000 0x10000>;
+				reg = <0x90000000 0x2000>;
 				interrupts = <27>;
 				clocks = <&clks 5>;
 			};
+
+			memc-monitor {
+				compatible = "sirf,prima2-memcmon";
+				reg = <0x90002000 0x200>;
+				interrupts = <4>;
+				clocks = <&clks 32>;
+			};
 		};
 
 		disp-iobg {
-- 
1.8.2.3
