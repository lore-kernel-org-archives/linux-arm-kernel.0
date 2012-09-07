From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Sep 2012 12:14:44 +0100
Subject: [PATCH 04/19] ARM: ux500: Add SDI (MMC) support to the HREF Device
 Tree
In-Reply-To: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1347016499-29354-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we add the Device Tree nodes which are required to successfully
probe the MMCI driver which will enable the four cards available on
ST-Ericsson's HREF hardware development platform.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefv60plus.dts |   45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 32cd7a0..62b2ac1 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -32,5 +32,50 @@
 		uart at 80007000 {
 			status = "okay";
 		};
+
+		// External Micro SD slot
+		sdi at 80126000 {
+			arm,primecell-periphid = <0x10480180>;
+			max-frequency = <50000000>;
+			bus-width = <8>;
+			mmc-cap-sd-highspeed;
+			mmc-cap-mmc-highspeed;
+			vmmc-supply = <&ab8500_ldo_aux3_reg>;
+
+			#gpio-cells = <1>;
+			cd-gpios  = <&gpio2 31 0x4>; // 95
+
+			status = "okay";
+		};
+
+		// WLAN SDIO channel
+		sdi at 80118000 {
+			arm,primecell-periphid = <0x10480180>;
+			max-frequency = <50000000>;
+			bus-width = <4>;
+
+			status = "okay";
+		};
+
+		// PoP:ed eMMC
+		sdi at 80005000 {
+			arm,primecell-periphid = <0x10480180>;
+			max-frequency = <50000000>;
+			bus-width = <8>;
+			mmc-cap-mmc-highspeed;
+
+			status = "okay";
+		};
+
+		// On-board eMMC
+		sdi at 80114000 {
+			arm,primecell-periphid = <0x10480180>;
+		        max-frequency = <50000000>;
+			bus-width = <8>;
+			mmc-cap-mmc-highspeed;
+			vmmc-supply = <&ab8500_ldo_aux2_reg>;
+
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5
