From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 28 Oct 2016 21:36:56 +0900
Subject: [PATCH v2 2/8] ARM: dts: tps65217: Add the charger device
In-Reply-To: <20161028123702.21849-1-woogyom.kim@gmail.com>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
Message-ID: <20161028123702.21849-3-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the charger driver and disable it by default.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/tps65217.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 27935f8..8f77d0d 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -16,6 +16,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	charger {
+		compatible = "ti,tps65217-charger";
+		status = "disabled";
+	};
+
 	regulators {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.9.3
