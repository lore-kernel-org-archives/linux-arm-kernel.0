From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 29 Jan 2013 18:26:18 +0530
Subject: [PATCH 2/7] ARM: DT: tegra114: add GPIO DT entry
In-Reply-To: <1359464183-6255-1-git-send-email-ldewangan@nvidia.com>
References: <1359464183-6255-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1359464183-6255-3-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra114 has the GPIO controllers with 8 GPIO bank and each bank
supports 32 pins.

Add DT entry for GPIO controller. Tegra114 GPIO controller is
compatible with Tegra30 GPIO controller driver.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 96a8235..9ce1a68 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -37,6 +37,23 @@
 		reg = <0x6000c004 0x14c>;
 	};
 
+	gpio: gpio {
+		compatible = "nvidia,tegra114-gpio", "nvidia,tegra30-gpio";
+		reg = <0x6000d000 0x1000>;
+		interrupts = <0 32 0x04
+			      0 33 0x04
+			      0 34 0x04
+			      0 35 0x04
+			      0 55 0x04
+			      0 87 0x04
+			      0 89 0x04
+			      0 125 0x04>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
 	serial at 70006000 {
 		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
 		reg = <0x70006000 0x40>;
-- 
1.7.1.1
