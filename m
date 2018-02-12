From: joel@jms.id.au (Joel Stanley)
Date: Mon, 12 Feb 2018 18:13:21 +1030
Subject: [PATCH 2/6] ARM: dts: aspeed: Enable IPMI BT node on OpenPower
 machines
In-Reply-To: <20180212074325.23436-1-joel@jms.id.au>
References: <20180212074325.23436-1-joel@jms.id.au>
Message-ID: <20180212074325.23436-3-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These BMC systems require this device to communicate with the host.

Acked-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts    | 4 ++++
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts     | 4 ++++
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 4 ++++
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts       | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index 4379d09a261f..5115247e5e59 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -111,3 +111,7 @@
 &vuart {
 	status = "okay";
 };
+
+&ibt {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 623b6ab42021..d41be52c2393 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -257,3 +257,7 @@
 		aspeed,fan-tach-ch = /bits/ 8 <0x0e>;
 	};
 };
+
+&ibt {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 5f9049d2c4c3..7056231cbee6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -546,3 +546,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdtrst1_default>;
 };
+
+&ibt {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index c881484a85cf..ebe726a0d311 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -424,3 +424,7 @@
 		aspeed,fan-tach-ch = /bits/ 8 <0x03>;
 	};
 };
+
+&ibt {
+	status = "okay";
+};
-- 
2.15.1
