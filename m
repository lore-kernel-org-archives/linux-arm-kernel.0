From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 17 Sep 2018 13:35:59 +0200
Subject: [PATCH v2 5/5] DT: marvell,mmp2: Add SSP1 and SSP3
In-Reply-To: <20180917113559.11101-1-lkundrak@v3.sk>
References: <20180917113559.11101-1-lkundrak@v3.sk>
Message-ID: <20180917113559.11101-6-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There seem to be SSP2, SSP4 and perhaps SSP5 too, but Marvel keeps their
base addresses secret.

The SSP1 and SSP3 addresses were taken from OLPC 1.75, OpenFirmware and
kernel respectively.

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 766bbb8495b6..ba55d6483ed0 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -18,6 +18,8 @@
 		serial3 = &uart4;
 		i2c0 = &twsi1;
 		i2c1 = &twsi2;
+		spi0 = &ssp1;
+		spi3 = &ssp3;
 	};
 
 	soc {
@@ -239,6 +241,22 @@
 				resets = <&soc_clocks MMP2_CLK_RTC>;
 				status = "disabled";
 			};
+
+			ssp1: ssp at d4035000 {
+				compatible = "marvell,mmp2-ssp";
+				reg = <0xd4035000 0x1000>;
+				clocks = <&soc_clocks MMP2_CLK_SSP0>;
+				interrupts = <0>;
+				status = "disabled";
+			};
+
+			ssp3: ssp at d4037000 {
+				compatible = "marvell,mmp2-ssp";
+				reg = <0xd4037000 0x1000>;
+				clocks = <&soc_clocks MMP2_CLK_SSP2>;
+				interrupts = <20>;
+				status = "disabled";
+			};
 		};
 
 		soc_clocks: clocks{
-- 
2.17.1
