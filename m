From: chris.brandt@renesas.com (Chris Brandt)
Date: Thu,  1 Sep 2016 21:40:12 -0400
Subject: [PATCH v2 3/3] ARM: dts: rskrza1: add ethernet DT support
In-Reply-To: <20160902014012.9383-1-chris.brandt@renesas.com>
References: <20160901155430.23400-1-chris.brandt@renesas.com>
 <20160902014012.9383-1-chris.brandt@renesas.com>
Message-ID: <20160902014012.9383-3-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r7s72100-rskrza1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-rskrza1.dts b/arch/arm/boot/dts/r7s72100-rskrza1.dts
index aabfa04..e5dea5b 100644
--- a/arch/arm/boot/dts/r7s72100-rskrza1.dts
+++ b/arch/arm/boot/dts/r7s72100-rskrza1.dts
@@ -47,6 +47,15 @@
 	status = "okay";
 };
 
+&ether {
+	status = "okay";
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
 &scif2 {
 	status = "okay";
 };
-- 
2.9.2
