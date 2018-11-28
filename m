From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 28 Nov 2018 18:53:14 +0100
Subject: [PATCH v4 10/20] DT: marvell,mmp2: Add SSP controllers
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
Message-ID: <20181128175324.163202-11-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Despite Marvel keeps their base addresses secret there's a good chance
they're actually correct.

SSP1 and SSP3 bases were taken from OLPC 1.75: OpenFirmware and kernel
respectively. SSP2 and SSP4 addresses are from James Cameron who actually
has a copy of the data sheet.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- Added SSP2 and SSP4 (thanks James Cameron <quozl@laptop.org>)

Changes since v1:
- Dropped the aliases

 arch/arm/boot/dts/mmp2.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 0c5a51b98c3f..ee03e0846740 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -346,6 +346,38 @@
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
+			ssp2: ssp at d4036000 {
+				compatible = "marvell,mmp2-ssp";
+				reg = <0xd4036000 0x1000>;
+				clocks = <&soc_clocks MMP2_CLK_SSP1>;
+				interrupts = <1>;
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
+
+			ssp4: ssp at d4039000 {
+				compatible = "marvell,mmp2-ssp";
+				reg = <0xd4039000 0x1000>;
+				clocks = <&soc_clocks MMP2_CLK_SSP3>;
+				interrupts = <21>;
+				status = "disabled";
+			};
 		};
 
 		soc_clocks: clocks{
-- 
2.19.1
