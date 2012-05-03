From: hdoyu@nvidia.com (Hiroshi DOYU)
Date: Thu,  3 May 2012 19:05:45 +0300
Subject: [PATCHv3 4/4] ARM: dt: tegra: Add device tree support for AHB
In-Reply-To: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com>
References: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1336061147-10245-4-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add AHB entry for tegra20/30.

Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    5 +++++
 arch/arm/boot/dts/tegra30.dtsi |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 52cab08..ea6de57 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -212,5 +212,10 @@
 		reg = < 0x7000f000 0x00000100    /* controller registers */
 		        0x58000000 0x02000000 >; /* GART aperture */
 	};
+
+	ahb: ahb at 6000c004 {
+		compatible = "nvidia,tegra20-ahb";
+		reg = <0x6000c004 0x10c>; /* AHB Arbitration + Gizmo Controller */
+	};
 };
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 15200a9..9d650fb 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -224,4 +224,9 @@
 			nvidia,ahub-cif-ids = <8 8>;
 		};
 	};
+
+	ahb: ahb at 6000c004 {
+		compatible = "nvidia,tegra30-ahb";
+		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
+	};
 };
-- 
1.7.5.4
