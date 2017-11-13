From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 14 Nov 2017 00:23:21 +0300
Subject: [PATCH 2/2] arm64: dts: renesas: eagle: specify EtherAVB PHY IRQ
Message-ID: <20171113213152.819421744@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify  EtherAVB PHY IRQ  in the Eagle board's device tree, now that we
have the GPIO support (previously phylib had to resort to polling).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -44,6 +44,8 @@
 	phy0: ethernet-phy at 0 {
 		rxc-skew-ps = <1500>;
 		reg = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
