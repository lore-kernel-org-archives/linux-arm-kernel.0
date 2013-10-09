From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 9 Oct 2013 18:31:06 +0300
Subject: [PATCHv8 35/36] ARM: dts: AM43xx: link in clock DT data
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Message-ID: <1381332668-962-36-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock tree data is now included from base am4372.dtsi file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am4372.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0fe393a..218c1bd 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -412,4 +412,11 @@
 			status = "disabled";
 		};
 	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		/include/ "am43xx-clocks.dtsi"
+	};
 };
-- 
1.7.9.5
