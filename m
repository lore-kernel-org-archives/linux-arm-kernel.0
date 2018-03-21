From: rrajk@nvidia.com (Rajkumar Rampelli)
Date: Wed, 21 Mar 2018 10:10:41 +0530
Subject: [PATCH V2 6/9] arm64: tegra: Add pwm based fan support on Tegra186
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
Message-ID: <1521607244-29734-7-git-send-email-rrajk@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pwm fan driver support on Tegra186 SoC.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Removed generic-pwm-tachometer driver dt node and using pwm-fan driver
    for reading fan speed.

 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 19e1afc..27ae73e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1053,4 +1053,10 @@
 		reset-names = "tachometer";
 		status = "disabled";
 	};
+
+	pwm_fan {
+		compatible = "pwm-fan";
+		pwms = <&tegra_tachometer 0 1000000>;
+		status = "disabled";
+	};
 };
-- 
2.1.4
