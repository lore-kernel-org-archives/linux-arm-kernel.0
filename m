From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:50:06 +0200
Subject: [PATCH 19/26] ARM: dts: rskrza1: add ethernet DT support
In-Reply-To: <cover.1473234371.git.horms+renesas@verge.net.au>
References: <cover.1473234371.git.horms+renesas@verge.net.au>
Message-ID: <0aa8d831e75ec8b6c003943ece980535ab6cc94f.1473234372.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-rskrza1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-rskrza1.dts b/arch/arm/boot/dts/r7s72100-rskrza1.dts
index aabfa0459dc1..e5dea5bb4032 100644
--- a/arch/arm/boot/dts/r7s72100-rskrza1.dts
+++ b/arch/arm/boot/dts/r7s72100-rskrza1.dts
@@ -47,6 +47,15 @@
 	status = "okay";
 };
 
+&ether {
+	status = "okay";
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
 &scif2 {
 	status = "okay";
 };
-- 
2.7.0.rc3.207.g0ac5344
