From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 17 Apr 2017 23:42:44 +0200
Subject: [PATCH 1/1] ARM: dts: meson: Extend L2 cache controller node for
 Meson8 and Meson8b
In-Reply-To: <20170417214244.23698-1-martin.blumenstingl@googlemail.com>
References: <20170417214244.23698-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170417214244.23698-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This patch extends the L2 cache controller node for the Amlogic Meson8
and Meson8b SoCs with some missing parameters. These are taken from the
Amlogic GPL kernel source.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
[apply the change to Meson8 and Meson8b and updated description]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi  | 6 ++++++
 arch/arm/boot/dts/meson8b.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 5eaaf067c76a..6993077331c7 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -188,6 +188,12 @@
 	clocks = <&clk81>;
 };
 
+&L2 {
+	arm,data-latency = <3 3 3>;
+	arm,tag-latency = <2 2 2>;
+	arm,filter-ranges = <0x100000 0xc0000000>;
+};
+
 &spifc {
 	clocks = <&clk81>;
 };
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index ef9ac974111c..d9f116a418b2 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -171,6 +171,12 @@
 	};
 };
 
+&L2 {
+	arm,data-latency = <3 3 3>;
+	arm,tag-latency = <2 2 2>;
+	arm,filter-ranges = <0x100000 0xc0000000>;
+};
+
 &uart_AO {
 	clocks = <&clkc CLKID_CLK81>;
 };
-- 
2.12.2
