From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 29 Aug 2013 16:16:35 +0300
Subject: [PATCHv6 43/45] ARM: dts: DRA7: link in clock DT data
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Message-ID: <1377782197-10611-44-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock tree DT data is now included from base dra7.dtsi file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c01ef76..c98997b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -572,4 +572,18 @@
 			status = "disabled";
 		};
 	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		/include/ "dra7xx-clocks.dtsi"
+	};
+
+	clockdomains {
+		coreaon_clkdm: coreaon_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll_usb_ck>;
+		};
+	};
 };
-- 
1.7.9.5
