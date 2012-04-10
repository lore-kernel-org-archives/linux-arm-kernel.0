From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 10 Apr 2012 17:19:39 -0600
Subject: [PATCH V2 4/5] ARM: dt: tegra30.dtsi: Add audio-related nodes
In-Reply-To: <1334099980-19527-1-git-send-email-swarren@wwwdotorg.org>
References: <1334099980-19527-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1334099980-19527-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Add nodes for the Tegra30 AHUB and I2S controllers.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2:
* Move I2S nodes inside AHUB node, since it's the bus that contains them.
* Correct APBIF reg size
* Add nvidia,ahub-cif-ids to I2S nodes
---
 arch/arm/boot/dts/tegra30.dtsi |   41 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 62a7b39..98c29d1 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -183,4 +183,45 @@
 		reg = < 0x70000868 0xd0     /* Pad control registers */
 			0x70003000 0x3e0 >; /* Mux registers */
 	};
+
+	ahub at 70080000 {
+		compatible = "nvidia,tegra30-ahub";
+		reg = <0x70080000 0x200 0x70080200 0x100>;
+		interrupts = < 0 103 0x04 >;
+		nvidia,dma-request-selector = <&apbdma 1>;
+
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		tegra_i2s0: i2s at 70080300 {
+			compatible = "nvidia,tegra30-i2s";
+			reg = <0x70080300 0x100>;
+			nvidia,ahub-cif-ids = <4 4>;
+		};
+
+		tegra_i2s1: i2s at 70080400 {
+			compatible = "nvidia,tegra30-i2s";
+			reg = <0x70080400 0x100>;
+			nvidia,ahub-cif-ids = <5 5>;
+		};
+
+		tegra_i2s2: i2s at 70080500 {
+			compatible = "nvidia,tegra30-i2s";
+			reg = <0x70080500 0x100>;
+			nvidia,ahub-cif-ids = <6 6>;
+		};
+
+		tegra_i2s3: i2s at 70080600 {
+			compatible = "nvidia,tegra30-i2s";
+			reg = <0x70080600 0x100>;
+			nvidia,ahub-cif-ids = <7 7>;
+		};
+
+		tegra_i2s4: i2s at 70080700 {
+			compatible = "nvidia,tegra30-i2s";
+			reg = <0x70080700 0x100>;
+			nvidia,ahub-cif-ids = <8 8>;
+		};
+	};
 };
-- 
1.7.0.4
