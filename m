From: rrajk@nvidia.com (Rajkumar Rampelli)
Date: Wed, 21 Feb 2018 12:28:53 +0530
Subject: [PATCH 04/10] hwmon: generic-pwm-tachometer: Add DT binding details
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
Message-ID: <1519196339-9377-5-git-send-email-rrajk@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding details for the PWM based generic tachometer
driver which gets the period of the PWM tach-output from Fan
via PWM IP having capability of capturing the signal.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 .../bindings/hwmon/generic-pwm-tachometer.txt      | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/generic-pwm-tachometer.txt

diff --git a/Documentation/devicetree/bindings/hwmon/generic-pwm-tachometer.txt b/Documentation/devicetree/bindings/hwmon/generic-pwm-tachometer.txt
new file mode 100644
index 0000000..3541fe5
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/generic-pwm-tachometer.txt
@@ -0,0 +1,25 @@
+Device tree bindings for fan tach output connected to PWM controller with
+PWM capture capability.
+
+Required properties:
+- compatible : Should be "generic-pwm-tachometer"
+- pwms       : PWM handle. Please refer pwm.txt DT binding for more details.
+
+Example:
+	tegra_tachometer: tachometer at 39c0000 {
+		compatible = "nvidia,tegra186-pwm-tachometer";
+		reg = <0x0 0x039c0000 0x0 0x10>;
+		clocks = <&bpmp_clks TEGRA194_CLK_TACH>;
+		clock-names = "tachometer";
+		resets = <&bpmp_resets TEGRA194_RESET_TACH>;
+		reset-names = "tachometer";
+		nvidia,pulse-per-rev = <2>;
+		nvidia,sampling-window = <2>;
+		status = "okay";
+	};
+
+	generic_pwm_tachometer {
+		compatible = "generic-pwm-tachometer";
+		pwms = <&tegra_tachometer 0 1000000>;
+		status = "okay";
+	};
-- 
2.1.4
