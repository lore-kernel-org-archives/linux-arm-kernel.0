From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 22 May 2017 10:51:40 +0200
Subject: [PATCH v4 3/3] ARM: socfpga: dtsi: add dw-wdt reset lines
In-Reply-To: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de>
References: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de>
Message-ID: <1606b1da6758142628496ae85b15b3f89f0f928d.1495443015.git-series.s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the reset lines to both watchdogs.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/socfpga.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b2674bdb8e6a..547b2720abf5 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -924,6 +924,7 @@
 			reg = <0xffd02000 0x1000>;
 			interrupts = <0 171 4>;
 			clocks = <&osc1>;
+			resets = <&rst L4WD0_RESET>;
 			status = "disabled";
 		};
 
@@ -932,6 +933,7 @@
 			reg = <0xffd03000 0x1000>;
 			interrupts = <0 172 4>;
 			clocks = <&osc1>;
+			resets = <&rst L4WD1_RESET>;
 			status = "disabled";
 		};
 	};
-- 
git-series 0.9.1
