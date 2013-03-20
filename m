From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 20 Mar 2013 19:14:28 +0530
Subject: [PATCH 2/4] ARM: tegra: dalmore: add cpu regulator's node
In-Reply-To: <1363787070-14801-1-git-send-email-ldewangan@nvidia.com>
References: <1363787070-14801-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1363787070-14801-3-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dalmore uses the TPS51632 as cpu regulator. This device
is connected on I2C5.

Add dt node for this device.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index a61974e..6be9434 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -718,6 +718,21 @@
 		clock-frequency = <408000000>;
 	};
 
+	i2c at 7000d000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		tps51632 {
+			compatible = "ti,tps51632";
+			reg = <0x43>;
+			regulator-name = "vdd-cpu";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1520000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+	};
+
 	pmc {
 		nvidia,invert-interrupt;
 	};
-- 
1.7.1.1
