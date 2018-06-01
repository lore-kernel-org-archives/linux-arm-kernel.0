From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 1 Jun 2018 23:45:55 +0300
Subject: [PATCH 2/3] arm64: dts: renesas: condor: specify EtherAVB PHY IRQ
In-Reply-To: <4acc208e-c593-1e8a-00ca-fc9a5574074e@cogentembedded.com>
References: <4acc208e-c593-1e8a-00ca-fc9a5574074e@cogentembedded.com>
Message-ID: <21578b79-7ba0-b3a6-ae45-7e9ffbb7c8db@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify EtherAVB PHY IRQ in the Condor board's device tree, now that
we have the GPIO support (previously phylib had to resort to polling).

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -59,6 +59,8 @@
 	phy0: ethernet-phy at 0 {
 		rxc-skew-ps = <1500>;
 		reg = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
