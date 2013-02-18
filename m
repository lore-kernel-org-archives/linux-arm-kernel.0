From: wni@nvidia.com (Wei Ni)
Date: Mon, 18 Feb 2013 19:30:23 +0800
Subject: [RFC PATCH 1/9] ARM: dt: t30 cardhu: add dt entry for lm90
In-Reply-To: <1361187031-3679-1-git-send-email-wni@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
Message-ID: <1361187031-3679-2-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable thermal sensor lm90 in the dts file.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra30-cardhu.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index bdb2a66..15ad1ad 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -273,6 +273,13 @@
 				};
 			};
 		};
+
+		nct1008: lm90 at 4c {
+			compatible = "lm90";
+			reg = <0x4c>;
+			interrupt-parent = <&gpio>;
+			interrupts = <226 0x08>; /* gpio PCC2 */
+		};
 	};
 
 	spi at 7000da00 {
-- 
1.7.9.5
