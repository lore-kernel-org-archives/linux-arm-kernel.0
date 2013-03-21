From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 21 Mar 2013 19:17:40 +0530
Subject: [PATCH V2 1/4] ARM: tegra: dalmore: add cpu regulator node
In-Reply-To: <1363873663-19272-1-git-send-email-ldewangan@nvidia.com>
References: <1363873663-19272-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1363873663-19272-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dalmore uses the TPS51632 as CPU regulator. The device is connected
on I2C5.

Add DT node for TPS51632.

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
