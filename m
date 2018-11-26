From: plaes@plaes.org (Priit Laes)
Date: Mon, 26 Nov 2018 17:27:49 +0200
Subject: [PATCH 08/14] regulator: dts: enable soft-start and ramp delay for
 the OLinuXino Lime2
In-Reply-To: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
Message-ID: <3fd79fcb96c8ead9fa5a3a85a080caf00f186e36.1543245984.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The OLinuXino Lime2 has a big capacitor on its LDO3 output. It is
actually too large, causing the PMIC to shutdown when toggling the LDO3.

By enabling soft-start and ramp delay we increase the time for the
capacitor to charge lowering the current drain on the power regulator.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index b828677..ffafe97 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -245,6 +245,8 @@
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
 	regulator-name = "vddio-csi0";
+	regulator-soft-start;
+	regulator-ramp-delay = <1600>;
 };
 
 &reg_ldo4 {
-- 
git-series 0.9.1
