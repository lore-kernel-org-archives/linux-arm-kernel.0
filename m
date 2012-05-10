From: hdoyu@nvidia.com (Hiroshi DOYU)
Date: Thu, 10 May 2012 10:42:31 +0300
Subject: [PATCH 2/4] ARM: dt: tegra20.dtsi: Add Memory Controller(MC) nodes
In-Reply-To: <1336635764-30597-1-git-send-email-hdoyu@nvidia.com>
References: <1336635764-30597-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1336635764-30597-2-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Tegra MC(Memory Controller) nodes for tegra20.dtsi.

Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 24129fb..548b42e 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -211,5 +211,12 @@
 		compatible = "nvidia,tegra20-ahb";
 		reg = <0x6000c004 0x10c>; /* AHB Arbitration + Gizmo Controller */
 	};
+
+	mc {
+		compatible = "nvidia,tegra20-mc";
+		reg = <0x7000f000 0x024
+		       0x7000f03c 0x3c4>;
+		interrupts = <0 77 0x04>;
+	};
 };
 
-- 
1.7.5.4
