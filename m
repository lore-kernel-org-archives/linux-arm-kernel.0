From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 15 Feb 2017 10:13:57 +0800
Subject: [PATCH 2/2] arm64: dts: mediatek: Add mt8176 device tree
In-Reply-To: <20170215021405.18689-1-djkurtz@chromium.org>
References: <1486445710-40140-1-git-send-email-yidi.lin@mediatek.com>
 <20170215021405.18689-1-djkurtz@chromium.org>
Message-ID: <20170215021405.18689-2-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MT8176 is a member of the MT817x family of SoCs.
Its device tree inherits from mt817x, and only describes the mt8176
specific cpu map and cooling contributions.

Signed-off-by: Yidi Lin <yidi.lin@mediatek.com>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8176.dtsi | 107 +++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8176.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt8176.dtsi b/arch/arm64/boot/dts/mediatek/mt8176.dtsi
new file mode 100644
index 000000000000..79a99ba12ba0
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8176.dtsi
@@ -0,0 +1,107 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "mt817x.dtsi"
+
+/ {
+	compatible = "mediatek,mt8176";
+};
+
+&cpus {
+	cpu-map {
+		cluster0 {
+			core0 {
+				cpu = <&cpu0>;
+			};
+			core1 {
+				cpu = <&cpu1>;
+			};
+			core2 {
+				cpu = <&cpu2>;
+			};
+			core3 {
+				cpu = <&cpu3>;
+			};
+		};
+
+		cluster1 {
+			core0 {
+				cpu = <&cpu4>;
+			};
+			core1 {
+				cpu = <&cpu5>;
+			};
+		};
+	};
+
+	cpu0: cpu at 0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x000>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+	};
+
+	cpu1: cpu at 1 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x001>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+	};
+
+	cpu2: cpu at 2 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x002>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+	};
+
+	cpu3: cpu at 3 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a53";
+		reg = <0x003>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+	};
+
+	cpu4: cpu at 100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x100>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+	};
+
+	cpu5: cpu at 101 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a57";
+		reg = <0x101>;
+		enable-method = "psci";
+		cpu-idle-states = <&CPU_SLEEP_0>;
+	};
+};
+
+&cpu_thermal {
+	cooling-maps {
+		map at 0 {
+			trip = <&target>;
+			cooling-device = <&cpu0 0 0>;
+			contribution = <3072>;
+		};
+		map at 1 {
+			trip = <&target>;
+			cooling-device = <&cpu4 0 0>;
+			contribution = <1024>;
+		};
+	};
+};
-- 
2.11.0.483.g087da7b7c-goog
