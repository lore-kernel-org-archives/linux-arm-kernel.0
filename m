From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 24 Oct 2018 17:33:53 +0200
Subject: [PATCH 2/2] arm64: tegra: Add PWM fan support on Jetson Xavier
In-Reply-To: <20181024153353.15745-1-thierry.reding@gmail.com>
References: <20181024153353.15745-1-thierry.reding@gmail.com>
Message-ID: <20181024153353.15745-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Enable PWM4 in device tree and use it to drive the PWM fan on the Jetson
Xavier.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index 9ff3c18280c4..86f05504ca38 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -12,5 +12,14 @@
 		sdhci at 3400000 {
 			status = "okay";
 		};
+
+		pwm at c340000 {
+			status = "okay";
+		};
+	};
+
+	fan {
+		compatible = "pwm-fan";
+		pwms = <&pwm4 0 45334>;
 	};
 };
-- 
2.19.1
