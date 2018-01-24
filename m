From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 24 Jan 2018 11:39:41 +0100
Subject: [linux-sunxi][PATCH 3/5] arm64: allwinner: a64: Add SPDIF to the A64
In-Reply-To: <20180124103943.2062-1-codekipper@gmail.com>
References: <20180124103943.2062-1-codekipper@gmail.com>
Message-ID: <20180124103943.2062-4-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the device tree sound bindings for the S/PDIF block.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index db1694ec3ee4..f060a58f374c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -112,6 +112,25 @@
 		method = "smc";
 	};
 
+
+	sound_spdif {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "On-board SPDIF";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.16.0
