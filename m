From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 13 Apr 2017 06:32:35 -0700
Subject: [PATCH 1/8] Revert "ARM: dts: imx: Remove unexistant property"
In-Reply-To: <20170413133242.5068-1-andrew.smirnov@gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
Message-ID: <20170413133242.5068-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ca7734a ("regulator: anatop: Add support for
"anatop-enable-bit"") added code to support this particular binding
and 'anatop-enable-bit' is no longer an unused property.

This reverts commit 27958ccdf29e9971732e02494b48be54b0691269.

Cc: yurovsky at gmail.com
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 1 +
 arch/arm/boot/dts/imx7s.dtsi  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index b9d7d2d..6da2b77 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -542,6 +542,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
 				};
 
 				reg_arm: regulator-vddcore {
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index c4f12fd..22c9788 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -516,6 +516,7 @@
 					anatop-min-bit-val = <8>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1200000>;
+					anatop-enable-bit = <31>;
 				};
 			};
 
-- 
2.9.3
