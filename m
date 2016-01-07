From: louis.yu@mediatek.com (Louis Yu)
Date: Thu, 7 Jan 2016 20:09:44 +0800
Subject: [PATCH 2/2] ARM: dts: mt2701: enable basic SMP bringup for mt2701
In-Reply-To: <1452168584-25394-1-git-send-email-louis.yu@mediatek.com>
References: <1452168584-25394-1-git-send-email-louis.yu@mediatek.com>
Message-ID: <1452168584-25394-3-git-send-email-louis.yu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add enable method to support SMP.

Signed-off-by: Louis Yu <louis.yu@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 69f240f..1d72d82 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -23,6 +23,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "mediatek,mt81xx-tz-smp";
 
 		cpu at 0 {
 			device_type = "cpu";
@@ -46,6 +47,17 @@
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		trustzone-bootinfo at 80002000 {
+			compatible = "mediatek,trustzone-bootinfo";
+			reg = <0 0x80002000 0 0x1000>;
+		};
+	};
+
 	system_clk: dummy13m {
 		compatible = "fixed-clock";
 		clock-frequency = <13000000>;
-- 
1.7.9.5
