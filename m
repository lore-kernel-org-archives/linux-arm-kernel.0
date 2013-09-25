From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 25 Sep 2013 11:48:41 +0300
Subject: [PATCHv7 35/36] ARM: dts: AM43xx: link in clock DT data
In-Reply-To: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Message-ID: <1380098922-30340-36-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock tree data is now included from base am4372.dtsi file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
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
