From: serveralex@gmail.com (=?UTF-8?q?Alexander=20M=C3=BCller?=)
Date: Tue, 10 May 2016 22:08:36 +0200
Subject: [PATCH 2/6] ARM: DTS: Amlogic: Add ethernet pins
In-Reply-To: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
References: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
Message-ID: <1462910920-5462-3-git-send-email-serveralex@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pins for ethernet interface

Signed-off-by: Alexander M?ller <serveralex@gmail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 2bfe401..8ef2da8 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -171,6 +171,20 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 			};
+
+			ethernet_pins: ethernet {
+				mux {
+					groups = "eth_tx_clk", "eth_tx_en",
+						"eth_txd1_0", "eth_txd1_1",
+						"eth_txd0_0", "eth_txd0_1",
+						"eth_rx_clk", "eth_rx_dv",
+						"eth_rxd1", "eth_rxd0",
+						"eth_mdio_en", "eth_mdc",
+						"eth_ref_clk", "eth_txd2",
+						"eth_txd3";
+					function = "ethernet";
+				};
+			};
 		};
 
 		pinctrl_aobus: pinctrl at c8100084 {
-- 
2.5.0
