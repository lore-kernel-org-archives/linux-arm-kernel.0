From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 17 Nov 2015 11:10:40 -0800
Subject: [PATCH] ARM: shmobile: alt: Add pfc pins to DT
Message-ID: <1447787440-11080-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PFC is already enabled on the r8a7794.
This adds pins for devices already enabled in DT on
the r8a7794 based alt board.

Based on work by Mitsuhiro Kimura and Hisashi Nakamura.

Cc: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
Cc: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
Tested
---
 arch/arm/boot/dts/r8a7794-alt.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 928cfa641475..2e889991ce8f 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -39,6 +39,23 @@
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
