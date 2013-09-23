From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 24 Sep 2013 00:16:32 +0800
Subject: [PATCH 3/9] arm/dts: sirf: add missed graphics2d iobg in atlas6 dts
In-Reply-To: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
References: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1379952998-16393-4-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiansong Chen <jiansong.chen@csr.com>

there is a bus bridge for graphics 2D module lost in current dts, this patch takes it
back.

Signed-off-by: Jiansong Chen <jiansong.chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index be188de..b439b74 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -132,6 +132,20 @@
 			};
 		};
 
+		graphics2d-iobg {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xa0000000 0xa0000000 0x8000000>;
+
+			ble at a0000000 {
+				compatible = "sirf,atlas6-ble";
+				reg = <0xa0000000 0x2000>;
+				interrupts = <5>;
+				clocks = <&clks 33>;
+			};
+		};
+
 		dsp-iobg {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
1.8.2.3
