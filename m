From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 22 Sep 2018 17:10:02 +0200
Subject: [PATCH v2 4/5] ARM: dts: meson8b: add the RMII pins
In-Reply-To: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
References: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180922151003.4736-5-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards use an RMII Ethernet PHY which requires fewer pins than the
RGMII PHYs. Add a separate eth_rmii_pins node which does not include the
pins which are only required for RGMII (but not for RMII) PHYs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 4bbbbc6bea83..cd1ca9dda126 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -223,6 +223,21 @@
 			};
 		};
 
+		eth_rmii_pins: eth-rmii {
+			mux {
+				groups = "eth_tx_en",
+					 "eth_txd1_0",
+					 "eth_txd0_0",
+					 "eth_rx_clk",
+					 "eth_rx_dv",
+					 "eth_rxd1",
+					 "eth_rxd0",
+					 "eth_mdio_en",
+					 "eth_mdc";
+				function = "ethernet";
+			};
+		};
+
 		i2c_a_pins: i2c-a {
 			mux {
 				groups = "i2c_sda_a", "i2c_sck_a";
-- 
2.19.0
