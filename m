From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:34 -0800
Subject: [PATCH 27/29] ARM: shmobile: alt: Add pfc pins to DT
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <22b160713cb6944450dad0abd18d8929f60500dc.1447981420.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PFC is already enabled on the r8a7794.
This adds pins for devices already enabled in DT on
the r8a7794 based alt board.

Based on work by Mitsuhiro Kimura and Hisashi Nakamura.

Cc: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
Cc: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index a548007b9b10..e7c94554d847 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -100,6 +100,23 @@
 	clock-frequency = <20000000>;
 };
 
+&pfc {
+	scif2_pins: serial2 {
+		renesas,groups = "scif2_data";
+		renesas,function = "scif2";
+	};
+
+	ether_pins: ether {
+		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
+		renesas,function = "eth";
+	};
+
+	ether_b_pins: ether {
+		renesas,groups = "eth_link_b", "eth_mdio_b", "eth_rmii_b";
+		renesas,function = "eth";
+	};
+};
+
 &cmt0 {
 	status = "okay";
 };
-- 
2.1.4
