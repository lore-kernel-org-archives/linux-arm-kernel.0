From: mike.leach@linaro.org (Mike Leach)
Date: Wed, 11 Jan 2017 20:44:09 +0000
Subject: [PATCH v2 2/2] arm64: dts: juno: Adds missing CoreSight STM component.
In-Reply-To: <1484167449-14432-1-git-send-email-mike.leach@linaro.org>
References: <1484167449-14432-1-git-send-email-mike.leach@linaro.org>
Message-ID: <1484167449-14432-3-git-send-email-mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing CoreSight STM component definition to Juno CoreSight
infrastructure juno-cs-rX.dtsi files.

Component connected to different funnels depending on Juno platform variant.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-cs-r0.dtsi   | 16 ++++++++++++++++
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-cs-r0.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r0.dtsi
index 24419ed..4e01b0e 100644
--- a/arch/arm64/boot/dts/arm/juno-cs-r0.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-cs-r0.dtsi
@@ -148,3 +148,19 @@
 			};
 		};
 	};
+
+	stm at 20100000 {
+		compatible = "arm,coresight-stm", "arm,primecell";
+		reg = <0 0x20100000 0 0x1000>,
+		      <0 0x28000000 0 0x180000>;
+		reg-names = "stm-base", "stm-stimulus-base";
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		port {
+			stm_out_port: endpoint {
+				remote-endpoint = <&main_funnel_in_port2>;
+			};
+		};
+	};
diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
index caaf58e..6fe8b62 100644
--- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
@@ -248,3 +248,19 @@
 			};
 		};
 	};
+
+	stm at 20100000 {
+		compatible = "arm,coresight-stm", "arm,primecell";
+		reg = <0 0x20100000 0 0x1000>,
+		      <0 0x28000000 0 0x180000>;
+		reg-names = "stm-base", "stm-stimulus-base";
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+		port {
+			stm_out_port: endpoint {
+				remote-endpoint = <&csys1_funnel_in_port0>;
+			};
+		};
+	};
-- 
2.7.4
