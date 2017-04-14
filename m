From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 14 Apr 2017 21:15:55 +0800
Subject: [PATCH 2/2] arm64: allwinner: a64: enable EHCI0/OHCI0 for Pine64
In-Reply-To: <20170414131555.9431-1-icenowy@aosc.io>
References: <20170414131555.9431-1-icenowy@aosc.io>
Message-ID: <20170414131555.9431-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have USB0 controller switch available on A64, we should now enable
the EHCI0/OHCI0 controllers for Pine64.

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
