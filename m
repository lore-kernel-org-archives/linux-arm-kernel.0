From: hdoyu@nvidia.com (Hiroshi DOYU)
Date: Mon, 23 Apr 2012 14:58:55 +0300
Subject: [PATCH 3/3] arm/dts: Tegra30: Add device tree support for SMMU
In-Reply-To: <1335182340-17237-1-git-send-email-hdoyu@nvidia.com>
References: <1335182340-17237-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1335182340-17237-3-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support for Tegra30 IOMMU(SMMU).

Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 15200a9..f4929d5 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -224,4 +224,14 @@
 			nvidia,ahub-cif-ids = <8 8>;
 		};
 	};
+
+	smmu: smmu at 7000f000 {
+		compatible = "nvidia,tegra30-smmu";
+		reg = <0x7000f010 0x2c		/* controller registers */
+		       0x7000f1f0 0x10		/* statics */
+		       0x7000f228 0x5c>;	/* module configuration */
+		interrupts = <0 13 0x40>;
+		asids = <4>;			/* # of ASIDs */
+		dma-window = <0 0x40000000>;	/* IOVA start & length */
+	};
 };
-- 
1.7.5.4
