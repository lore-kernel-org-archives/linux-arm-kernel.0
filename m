From: 21cnbao@gmail.com (Barry Song)
Date: Thu,  9 Jan 2014 13:01:11 +0800
Subject: [PATCH 4/4] ARM: dts: sirf: add lost minigpsrtc device node
In-Reply-To: <1389243671-18099-1-git-send-email-21cnbao@gmail.com>
References: <1389243671-18099-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1389243671-18099-4-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xianglong Du <Xianglong.Du@csr.com>

This patch adds lost minigpsrtc device node for prima2 and atlas6,
which is behind rtc-iobg and whose offset is 2000.

Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |    6 ++++++
 arch/arm/boot/dts/prima2.dtsi |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 2b5d678..bc2d449 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -711,6 +711,12 @@
 				interrupts = <52 53 54>;
 			};
 
+			minigpsrtc at 2000 {
+				compatible = "sirf,prima2-minigpsrtc";
+				reg = <0x2000 0x1000>;
+				interrupts = <54>;
+			};
+
 			pwrc at 3000 {
 				compatible = "sirf,prima2-pwrc";
 				reg = <0x3000 0x1000>;
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 0942f9a..00a4b20 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -739,6 +739,12 @@
 				interrupts = <52 53 54>;
 			};
 
+			minigpsrtc at 2000 {
+				compatible = "sirf,prima2-minigpsrtc";
+				reg = <0x2000 0x1000>;
+				interrupts = <54>;
+			};
+
 			pwrc at 3000 {
 				compatible = "sirf,prima2-pwrc";
 				reg = <0x3000 0x1000>;
-- 
1.7.5.4
