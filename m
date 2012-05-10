From: hdoyu@nvidia.com (Hiroshi DOYU)
Date: Thu, 10 May 2012 10:42:33 +0300
Subject: [PATCH 4/4] ARM: dt: tegra30.dtsi: Add Memory Controller(MC) nodes
In-Reply-To: <1336635764-30597-1-git-send-email-hdoyu@nvidia.com>
References: <1336635764-30597-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1336635764-30597-4-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Tegra MC(Memory Controller) nodes for tegra30.dtsi.

Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 9d650fb..167ccbc 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -229,4 +229,13 @@
 		compatible = "nvidia,tegra30-ahb";
 		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
 	};
+
+	mc {
+		compatible = "nvidia,tegra30-mc";
+		reg = <0x7000f000 0x010
+		       0x7000f03c 0x1b4
+		       0x7000f200 0x028
+		       0x7000f284 0x17c>;
+		interrupts = <0 77 0x04>;
+	};
 };
-- 
1.7.5.4
