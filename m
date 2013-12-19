From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 19 Dec 2013 04:49:44 -0800
Subject: [PATCH 5/6] ARM: DTS: tegra: add DFLL integration to the Dalmore
 DTS file
In-Reply-To: <20131219122857.3226.42830.stgit@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
Message-ID: <20131219124929.3226.79335.stgit@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose the DFLL device on the NVIDIA Tegra114 Dalmore board, and connect
the DFLL (and FCPU cluster) voltage regulator.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Matthew Longnecker <mlongnecker@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
 .../bindings/clock/nvidia,tegra114-dfll.txt        |   16 ++++++++++++++++
 arch/arm/boot/dts/tegra114-dalmore.dts             |    4 ++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt
index b868bf97bc3d..c4072b3f16fc 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt
@@ -41,3 +41,19 @@ dfll at 70110000 {
         status = "disabled";
 };
 
+...
+
+NVIDIA Tegra114 DFLL clocksource data in the board DTS file
+
+Optional properties:
+
+- status : device availability -- managed by the DT integration code, not
+           the DFLL driver.  Should be set to "okay" if the DFLL is to be
+           used on this board type.
+
+
+Example:
+
+dfll at 70110000 {
+        status = "okay";
+};
diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 88be40cf8845..2e8e7ae60c1a 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1063,6 +1063,10 @@
 		};
 	};
 
+	dfll at 70110000 {
+		status = "okay";
+	};
+
 	sdhci at 78000400 {
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 		bus-width = <4>;
