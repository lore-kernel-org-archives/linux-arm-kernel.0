From: john.garry@huawei.com (John Garry)
Date: Mon, 30 Apr 2018 23:15:41 +0800
Subject: [PATCH 2/3] arm64: dts: hisi: Enable Hisi LPC node for hip06
In-Reply-To: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
References: <1525101342-27120-1-git-send-email-john.garry@huawei.com>
Message-ID: <1525101342-27120-3-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch enables the HiSi LPC node for hip06, with
IPMI and UART child devices.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts |  8 ++++++++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi    | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
index 9af6330..8ea1335 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
@@ -25,6 +25,14 @@
 	chosen { };
 };
 
+&ipmi0 {
+	status = "ok";
+};
+
+&uart0 {
+        status = "ok";
+};
+
 &eth0 {
 	status = "ok";
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 35202eb..d78a6a7 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -350,6 +350,27 @@
 		#size-cells = <2>;
 		ranges;
 
+		isa at a01b0000 {
+			compatible = "hisilicon,hip06-lpc";
+			#size-cells = <1>;
+			#address-cells = <2>;
+			reg = <0x0 0xa01b0000 0x0 0x1000>;
+
+			ipmi0: bt at e4 {
+				compatible = "ipmi-bt";
+				device_type = "ipmi";
+				reg = <0x01 0xe4 0x04>;
+				status = "disabled";
+			};
+
+			uart0: lpc-uart at 2f8 {
+				compatible = "ns16550a";
+				clock-frequency = <1843200>;
+				reg = <0x01 0x2f8 0x08>;
+				status = "disabled";
+			};
+		};
+
 		refclk: refclk {
 			compatible = "fixed-clock";
 			clock-frequency = <50000000>;
-- 
1.9.1
