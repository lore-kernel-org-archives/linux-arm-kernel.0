From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 09:03:59 +0000
Subject: [PATCH 05/10] ARM: dts: atlas7: add multimedia codec node
In-Reply-To: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
References: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438074244-18708-6-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiaofeng Fei <xiaofeng.fei@csr.com>

this patch adds multimedia video codec node, and also fixes the
ranges of its parent node.

Signed-off-by: Xiaofeng Fei <xiaofeng.fei@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index b872d12..5a98485 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1371,7 +1371,8 @@
 			compatible = "arteris, flexnoc", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x16000000 0x16000000 0x00200000>,
+			ranges = <0x15000000 0x15000000 0x00600000>,
+				<0x16000000 0x16000000 0x00200000>,
 				<0x17000000 0x17000000 0x10000>,
 				<0x17020000 0x17020000 0x1000>,
 				<0x17030000 0x17030000 0x1000>,
@@ -1383,6 +1384,13 @@
 				<0x17070200 0x17070200 0x100>,
 				<0x170A0000 0x170A0000 0x3000>;
 
+			multimedia at 15000000 {
+				compatible = "sirf,atlas7-video-codec";
+				reg = <0x15000000 0x10000>;
+				interrupts = <0 5 0>;
+				clocks = <&car 102>;
+			};
+
 			mediam at 170A0000 {
 				compatible = "sirf,nocfw-mediam";
 				reg = <0x170A0000 0x3000>;
-- 
1.9.1
