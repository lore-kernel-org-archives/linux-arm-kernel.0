From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  5 Apr 2017 02:45:18 +0800
Subject: [PATCH 3/3] arm64: allwinner: a64: enable EHCI0/OHCI0 controller for
 Pine64
In-Reply-To: <20170404184518.33610-1-icenowy@aosc.io>
References: <20170404184518.33610-1-icenowy@aosc.io>
Message-ID: <20170404184518.33610-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The upper USB port of Pine64 board is connected to the SoC's USB0 port,
which can now switch from the MUSB controller to the EHCI/OHCI pair.

Enable the EHCI/OHCI pair in the Pine64 device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index c680ed385da3..4782add50b94 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -66,6 +66,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -91,6 +95,10 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &ohci1 {
 	status = "okay";
 };
-- 
2.12.2
