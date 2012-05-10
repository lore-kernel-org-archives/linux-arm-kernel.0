From: hdoyu@nvidia.com (Hiroshi DOYU)
Date: Thu, 10 May 2012 10:45:33 +0300
Subject: [PATCH 2/2] ARM: dt: tegra20.dtsi: Add GART node
In-Reply-To: <1336635940-31068-1-git-send-email-hdoyu@nvidia.com>
References: <1336635940-31068-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1336635940-31068-2-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the Tegra20 GART

Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 548b42e..c6cf42e 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -207,6 +207,12 @@
 		phy_type = "utmi";
 	};
 
+	gart {
+		compatible = "nvidia,tegra20-gart";
+		reg = <0x7000f024 0x00000018	/* controller registers */
+		       0x58000000 0x02000000>;	/* GART aperture */
+	};
+
 	ahb: ahb at 6000c004 {
 		compatible = "nvidia,tegra20-ahb";
 		reg = <0x6000c004 0x10c>; /* AHB Arbitration + Gizmo Controller */
-- 
1.7.5.4
