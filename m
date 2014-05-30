From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 30 May 2014 07:43:08 -0600
Subject: [RFC PATCH 08/11] coresight: adding support for beagle board
In-Reply-To: <1401457391-12242-1-git-send-email-mathieu.poirier@linaro.org>
References: <1401457391-12242-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1401457391-12242-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Panchaxari Prasannamurthy <panchaxari.prasannamurthy@linaro.org>

Added support for coresight device in dts for Beagle Board, by adding
blocks of coresight, ETM, ETB blocks.

Signed-off-by: Panchaxari Prasannamurthy <panchaxari.prasannamurthy@linaro.org>
---
 arch/arm/boot/dts/omap3-beagle.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 5053766..0017084 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -80,6 +80,36 @@
 		};
 
 	};
+
+	coresight {
+		compatible = "arm,coresight";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&emu_src_ck>;
+		ranges;
+
+		etb: etb at 540000000 {
+			compatible = "arm,coresight-etb";
+			reg = <0x5401b000 0x1000>;
+
+			coresight-id = <0>;
+			coresight-name = "coresight-etb";
+			coresight-nr-inports = <1>;
+			coresight-default-sink;
+		};
+
+		etm at 54010000 {
+			compatible = "arm,coresight-etm";
+			reg = <0x54010000 0x1000>;
+
+			coresight-id = <1>;
+			coresight-name = "coresight-etm";
+			coresight-nr-inports = <0>;
+			coresight-outports = <0>;
+			coresight-child-list = <&etb>;
+			coresight-child-ports = <0>;
+		};
+	};
 };
 
 &omap3_pmx_wkup {
-- 
1.9.1
