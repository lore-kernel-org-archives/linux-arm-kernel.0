From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 28 Aug 2016 19:32:44 +0200
Subject: [PATCH 2/4] ARM: tegra: nyan: Use external control for bq24735 charger
In-Reply-To: <20160828173246.32621-1-contact@paulk.fr>
References: <20160828173246.32621-1-contact@paulk.fr>
Message-ID: <20160828173246.32621-2-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nyan boards come with an embedded controller that controls when to
enable and disable the charge. Thus, it should not be left up to the
kernel to handle that.

Using the ti,external-control property allows specifying this use-case.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 30a77ec..18db797 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -329,6 +329,7 @@
 					ti,ac-detect-gpios = <&gpio
 							TEGRA_GPIO(J, 0)
 							GPIO_ACTIVE_HIGH>;
+					ti,external-control;
 				};
 
 				battery: sbs-battery at b {
-- 
2.9.3
