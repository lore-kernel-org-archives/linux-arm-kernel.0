From: rrajk@nvidia.com (Rajkumar Rampelli)
Date: Wed, 21 Feb 2018 12:28:56 +0530
Subject: [PATCH 07/10] arm64: tegra: Add PWM based Tachometer support on
 Tegra186
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
Message-ID: <1519196339-9377-8-git-send-email-rrajk@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PWM based Tachometer support on Tegra186 to measure
number of rotations of a Fan per minute by using PWM
capture interface

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 8f2d598..37149e9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1042,4 +1042,10 @@
 		reset-names = "tachometer";
 		status = "disabled";
 	};
+
+	generic_pwm_tachometer {
+		compatible = "generic-pwm-tachometer";
+		pwms = <&tegra_tachometer 0 1000000>;
+		status = "disabled";
+	};
 };
-- 
2.1.4
