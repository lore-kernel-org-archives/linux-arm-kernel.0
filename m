From: stefan@agner.ch (Stefan Agner)
Date: Wed, 27 Nov 2013 00:45:45 +0100
Subject: [PATCH 3/3] ARM: tegra: set SM2 voltage correct
In-Reply-To: <cover.1385508112.git.stefan@agner.ch>
References: <cover.1385508112.git.stefan@agner.ch>
Message-ID: <c9ceead9e3df77b5a33ad654db23c241cd624096.1385508112.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the requested SM2 voltage to the correct value of 1.8V. The value
before used to work on TPS658623 since the driver applied a wrong
voltage table too. However, the TPS658643 used on newer devices uses
yet another voltage table and those broke that compatibility. The
regulator driver now has the correct voltage table for both regulator
versions and those the correct voltage can be used in this device
tree.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/tegra20-colibri-512.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index d5c9bca..cbe89ff 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -268,8 +268,8 @@
 					reg = <3>;
 					regulator-compatible = "sm2";
 					regulator-name = "vdd_sm2,vin_ldo*";
-					regulator-min-microvolt = <3700000>;
-					regulator-max-microvolt = <3700000>;
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
 					regulator-always-on;
 				};
 
-- 
1.8.4.2
