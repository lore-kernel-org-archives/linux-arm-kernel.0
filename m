From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 1 Jun 2018 23:47:14 +0300
Subject: [PATCH 3/3] arm64: dts: renesas: v3hsk: specify GEther PHY IRQ
In-Reply-To: <4acc208e-c593-1e8a-00ca-fc9a5574074e@cogentembedded.com>
References: <4acc208e-c593-1e8a-00ca-fc9a5574074e@cogentembedded.com>
Message-ID: <9e6c40eb-71d0-d35b-1cf7-9179e093ed10@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify GEther PHY IRQ in the V3H Starter Kit board's device tree, now
that we have the GPIO support (previously phylib had to resort to polling).

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
@@ -48,6 +48,8 @@
 
 	phy0: ethernet-phy at 0 {
 		reg = <0>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
