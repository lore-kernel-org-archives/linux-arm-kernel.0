From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 22 Jan 2017 16:47:49 +0100
Subject: [PATCH v2 2/6] ARM: tegra: nyan: Use external control for bq24735
 charger
In-Reply-To: <20170122154753.31942-1-contact@paulk.fr>
References: <20170122154753.31942-1-contact@paulk.fr>
Message-ID: <20170122154753.31942-2-contact@paulk.fr>
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
index ef430aa30152..5cf987b5401e 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -335,6 +335,7 @@
 					ti,ac-detect-gpios = <&gpio
 							TEGRA_GPIO(J, 0)
 							GPIO_ACTIVE_HIGH>;
+					ti,external-control;
 				};
 
 				battery: sbs-battery at b {
-- 
2.11.0
