From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 10 Aug 2012 11:32:50 +0200
Subject: [PATCH v2 2/2] ARM: imx/pcm043: add oftree support
In-Reply-To: <1344591170-13638-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1344591170-13638-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1344591170-13638-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

--
changes since (implicit) v1
(id:1343922986-32469-2-git-send-email-u.kleine-koenig at pengutronix.de)

 - add newlines between nodes
 - adapt to changes in patch 1
---
 arch/arm/boot/dts/phytec-pcm043.dtsi |   57 ++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 arch/arm/boot/dts/phytec-pcm043.dtsi

diff --git a/arch/arm/boot/dts/phytec-pcm043.dtsi b/arch/arm/boot/dts/phytec-pcm043.dtsi
new file mode 100644
index 0000000..e3b8690
--- /dev/null
+++ b/arch/arm/boot/dts/phytec-pcm043.dtsi
@@ -0,0 +1,57 @@
+/include/ "imx35.dtsi"
+
+/ {
+	soc {
+		aips at 40000000 { /* AIPS1 */
+			i2c at 43f80000 {
+				status = "okay";
+
+				tempsens at 4a {
+					compatible = "maxim,ds75";
+					reg = <0x4a>;
+				};
+
+				rtc8564 at 51 {
+					compatible = "nxp,pcf8563";
+					reg = <0x51>;
+				};
+
+				at24 at 52 {
+					compatible = "at,24c32";
+					reg = <0x52>;
+					pagesize = <32>;
+				};
+			};
+
+			serial at 43f90000 {
+				status = "okay";
+			};
+
+			serial at 43f94000 {
+				status = "okay";
+			};
+		};
+
+		spba at 50000000 {
+			serial at 5000c000 {
+				status = "okay";
+			};
+
+			fec at 50038000 {
+				status = "okay";
+			};
+		};
+
+		emi at 80000000 {
+			nor at a0000000 {
+				compatible = "cfi-flash";
+				reg = <0xa0000000 0x2000000>;
+				bank-width = <2>;
+			};
+
+			nand at bb000000 {
+				status = "okay";
+			};
+		};
+	};
+};
-- 
1.7.10.4
