From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  9 Jul 2014 16:07:39 +0100
Subject: [PATCH v4 08/10] ARM: STi: DT: Enable second sdhci controller for
 stih416 b2020 boards.
In-Reply-To: <1404918461-25390-1-git-send-email-peter.griffin@linaro.org>
References: <1404918461-25390-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1404918461-25390-9-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second controller is only present on the stih416 SoC. Also
mark this as non-removeable as its eMMC.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih416-b2020.dts  | 8 ++++++++
 arch/arm/boot/dts/stih416-b2020e.dts | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-b2020.dts b/arch/arm/boot/dts/stih416-b2020.dts
index 4e2df66..d42ff1d 100644
--- a/arch/arm/boot/dts/stih416-b2020.dts
+++ b/arch/arm/boot/dts/stih416-b2020.dts
@@ -12,4 +12,12 @@
 / {
 	model = "STiH416 B2020";
 	compatible = "st,stih416-b2020", "st,stih416";
+
+	soc {
+		mmc1: sdhci at fe81f000 {
+			status       = "okay";
+			bus-width    = <8>;
+			non-removable;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/stih416-b2020e.dts b/arch/arm/boot/dts/stih416-b2020e.dts
index ba0fa2c..68dfdaf 100644
--- a/arch/arm/boot/dts/stih416-b2020e.dts
+++ b/arch/arm/boot/dts/stih416-b2020e.dts
@@ -31,5 +31,11 @@
 		ethernet1: dwmac at fef08000 {
 			snps,reset-gpio = <&PIO0 7>;
 		};
+
+		mmc1: sdhci at fe81f000 {
+			status       = "okay";
+			bus-width    = <8>;
+			non-removable;
+		};
 	};
 };
-- 
1.9.1
