From: rrajk@nvidia.com (Rajkumar Rampelli)
Date: Wed, 21 Mar 2018 10:10:38 +0530
Subject: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree bindings
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
Message-ID: <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Supply Device tree binding documentation for the NVIDIA
Tegra186 SoC's Tachometer Controller

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
    Renamed dt property values of clock-names and reset-names to "tachometer"
    from "tach"

 .../bindings/pwm/pwm-tegra-tachometer.txt          | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt b/Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt
new file mode 100644
index 0000000..4a7ead4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt
@@ -0,0 +1,31 @@
+Bindings for a PWM based Tachometer driver
+
+Required properties:
+- compatible: Must be "nvidia,tegra186-pwm-tachometer"
+- reg: physical base addresses of the controller and length of
+  memory mapped region.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a
+  description of the cells format.
+- clocks: phandle list of tachometer clocks
+- clock-names: should be "tachometer". See clock-bindings.txt in documentations
+- resets: phandle to the reset controller for the Tachometer IP
+- reset-names: should be "tachometer". See reset.txt in documentations
+- nvidia,pulse-per-rev: Integer, pulses per revolution of a Fan. This value
+  obtained from Fan specification document.
+- nvidia,capture-window-len: Integer, window of the Fan Tach monitor, it indicates
+  that how many period of the input fan tach signal will the FAN TACH logic
+  monitor. Valid values are 1, 2, 4 and 8 only.
+
+Example:
+	tegra_tachometer: tachometer at 39c0000 {
+		compatible = "nvidia,tegra186-pwm-tachometer";
+		reg = <0x0 0x039c0000 0x0 0x10>;
+		#pwm-cells = <2>;
+		clocks = <&tegra_car TEGRA186_CLK_TACH>;
+		clock-names = "tachometer";
+		resets = <&tegra_car TEGRA186_RESET_TACH>;
+		reset-names = "tachometer";
+		nvidia,pulse-per-rev = <2>;
+		nvidia,capture-window-len = <2>;
+		status = "disabled";
+	};
-- 
2.1.4
