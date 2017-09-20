From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 20 Sep 2017 23:18:14 +0800
Subject: [RFC PATCH 7/7] arm64: allwinner: a64: enable AC and Battery for
 Pine64
In-Reply-To: <20170920151814.22461-1-icenowy@aosc.io>
References: <20170920151814.22461-1-icenowy@aosc.io>
Message-ID: <20170920151814.22461-8-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine64 boards (including the Plus variant) have a Micro-USB jack
with it's 5V connected to the ACIN of the AXP803 PMIC and a battery
connector connected to the battery pins of the AXP803 PMIC.

Enable AC and Battery power supplies for Pine64, in order to monitor
them in the system.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index d06e34b5d192..955f392af6a2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -113,6 +113,14 @@
 
 #include "axp803.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1800000>;
-- 
2.13.5
