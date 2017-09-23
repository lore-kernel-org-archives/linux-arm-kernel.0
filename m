From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 23 Sep 2017 08:15:31 +0800
Subject: [PATCH 3/3] arm64: allwinner: a64: set CPU regulator for Pine64
In-Reply-To: <20170923001531.14285-1-icenowy@aosc.io>
References: <20170923001531.14285-1-icenowy@aosc.io>
Message-ID: <20170923001531.14285-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DCDC2 regulator of the AXP803 PMIC is used for the voltage scaling
of the ARM cores on the A64 SoC.

Add this definition to enable it on Pine64.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index d06e34b5d192..cc77503091f1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -63,6 +63,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.13.5
