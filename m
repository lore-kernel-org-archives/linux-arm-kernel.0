From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 13 Feb 2018 14:24:14 +0300
Subject: [PATCH v2 2/2] arm64: dts: renesas: eagle: specify EtherAVB PHY IRQ
In-Reply-To: <038a791d-aa57-9c3d-eaea-09c5704ecb54@cogentembedded.com>
References: <038a791d-aa57-9c3d-eaea-09c5704ecb54@cogentembedded.com>
Message-ID: <0ccd631e-691a-2b15-7680-6e0c847a6ca2@cogentembedded.com>
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
 
