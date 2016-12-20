From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 20 Dec 2016 11:23:44 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sun6i: Mele I7: Enable internal audio
 codec
Message-ID: <20161220102344.2519-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The Mele I7 has an audio jack for the SoC's internal codec.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun6i-a31-i7.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
index f3468a14596e..a2193309a199 100644
--- a/arch/arm/boot/dts/sun6i-a31-i7.dts
+++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
@@ -71,6 +71,12 @@
 	};
 };
 
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP";
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.11.0
