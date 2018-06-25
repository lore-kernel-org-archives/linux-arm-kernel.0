From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:03:21 +0200
Subject: [PATCH 26/29] arm64: dts: renesas: condor/v3hsk: specify Ethernet PHY
 IRQs
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <ffbd52352208534a30d5bbe2e15ee9e5cbb98c6d.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Specify Ethernet PHY IRQs in the Condor/V3HSK board device trees, now that
we have the GPIO support (previously phylib had  to resort to polling).

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts | 2 ++
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
index cc3ee25f4e2d..9f25c407dfd7 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -59,6 +59,8 @@
 	phy0: ethernet-phy at 0 {
 		rxc-skew-ps = <1500>;
 		reg = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
index bb7e0e5cd57b..9dac42f8f804 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
@@ -48,6 +48,8 @@
 
 	phy0: ethernet-phy at 0 {
 		reg = <0>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.11.0
