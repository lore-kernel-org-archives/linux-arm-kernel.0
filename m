From: oskari@lemmela.net (Oskari Lemmela)
Date: Tue, 23 Oct 2018 21:53:26 +0300
Subject: [PATCH v5 07/11] arm64: dts: allwinner: a64: sopine-baseboard: enable
 power supplies
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Message-ID: <20181023185330.10472-8-oskari@lemmela.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP803 ACIN pins are routed from SOM to the DC jack on the baseboard.
AXP803 charger pins BATSENSE, LOADSENSE, N_BATDRV, LX_CHG, VIN_CHG
and IPSOUT are connected via PMOS driver to SOM VBAT pins. VBAT and
AXP803 TS pins are routed to the baseboard 3-pin battery connector.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index c21f2331add6..335cf2263d19 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -69,6 +69,14 @@
 	};
 };
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.17.1
