From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 22 May 2014 16:18:21 +0100
Subject: [PATCH 7/8] ARM: STi: DT: Enable second sdhci controller for stih416
 b2020 boards.
In-Reply-To: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1400771902-26553-8-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The second controller is only present on the stih416 SoC. Also
mark this as non-removeable as its eMMC.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 arch/arm/boot/dts/stih416-b2020.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-b2020.dts b/arch/arm/boot/dts/stih416-b2020.dts
index 4e2df66..6cde745 100644
--- a/arch/arm/boot/dts/stih416-b2020.dts
+++ b/arch/arm/boot/dts/stih416-b2020.dts
@@ -12,4 +12,12 @@
 / {
 	model = "STiH416 B2020";
 	compatible = "st,stih416-b2020", "st,stih416";
+
+	soc {
+		mmc1: sdhci at fe81f000 {
+			status = "okay";
+			non-removable;
+		};
+	};
+
 };
-- 
1.9.1
