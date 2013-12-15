From: horms+renesas@verge.net.au (Simon Horman)
Date: Sun, 15 Dec 2013 17:24:00 +0900
Subject: [PATCH RFC 2/2] ARM: shmobile: r7s72100: Add ethernet PFC node to DT
In-Reply-To: <1387095840-15008-1-git-send-email-horms+renesas@verge.net.au>
References: <1387095840-15008-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1387095840-15008-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This has not been well exercised.
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index 040aa0f..2ca0196 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -60,11 +60,34 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif2_pins>;
+	pinctrl-0 = <&scif2_pins &ethernet_pins>;
 	pinctrl-names = "default";
 
 	scif2_pins: serial2 {
 		renesas,groups = "scif2_txd_p3_0", "scif2_rxd_p3_2";
 		renesas,function = "scif2";
 	};
+
+	ethernet_pins: ethernet {
+		renesas,groups = "ethernet_rxdv_p3_6",
+				 "ethernet_rxer_p3_5",
+				 "ethernet_rxclk_p3_4",
+				 "ethernet_mdio_p3_3",
+				 "ethernet_rxd_p2_11",
+				 "ethernet_rxd_p2_10",
+				 "ethernet_rxd_p2_9",
+				 "ethernet_rxd_p2_8",
+				 "ethernet_txd_p2_7",
+				 "ethernet_txd_p2_6",
+				 "ethernet_txd_p2_5",
+				 "ethernet_txd_p2_4",
+				 "ethernet_txcrs_p2_3",
+				 "ethernet_txen_p2_2",
+				 "ethernet_txer_p2_1",
+				 "ethernet_txclk_p2_0",
+				 "ethernet_mdc_p5_9",
+				 "ethernet_col_p1_14",
+				 "ethernet_int_p1_15";
+		renesas,function = "ethernet";
+	};
 };
-- 
1.8.4
