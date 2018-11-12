From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:14 +0100
Subject: [PATCH v3 05/18] DT: marvell,mmp2: add MMC controllers
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
Message-ID: <20181112032027.653931-6-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's apparently four of them on a MMP2.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- The controllers seem to be on AXI bus, not APB. Move them.
- Remove aliases.

 arch/arm/boot/dts/mmp2.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 4743a1288280..063382b3eaca 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -117,6 +117,42 @@
 				reg-names = "mux status", "mux mask";
 				mrvl,intc-nr-irqs = <2>;
 			};
+
+			mmc1: mmc at d4280000 {
+				compatible = "mrvl,pxav3-mmc";
+				reg = <0xd4280000 0x120>;
+				clocks = <&soc_clocks MMP2_CLK_SDH0>;
+				clock-names = "io";
+				interrupts = <39>;
+				status = "disabled";
+			};
+
+			mmc2: mmc at d4280800 {
+				compatible = "mrvl,pxav3-mmc";
+				reg = <0xd4280800 0x120>;
+				clocks = <&soc_clocks MMP2_CLK_SDH1>;
+				clock-names = "io";
+				interrupts = <52>;
+				status = "disabled";
+			};
+
+			mmc3: mmc at d4281000 {
+				compatible = "mrvl,pxav3-mmc";
+				reg = <0xd4281000 0x120>;
+				clocks = <&soc_clocks MMP2_CLK_SDH2>;
+				clock-names = "io";
+				interrupts = <53>;
+				status = "disabled";
+			};
+
+			mmc4: mmc at d4288000 {
+				compatible = "mrvl,pxav3-mmc";
+				reg = <0xd4281800 0x120>;
+				clocks = <&soc_clocks MMP2_CLK_SDH3>;
+				clock-names = "io";
+				interrupts = <54>;
+				status = "disabled";
+			};
 		};
 
 		apb at d4000000 {	/* APB */
-- 
2.19.1
