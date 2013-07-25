From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Jul 2013 10:53:27 -0700
Subject: [PATCH v5 13/16] ARM: tegra: Fix Beaver's PCIe lane configuration
In-Reply-To: <1374774810-18459-1-git-send-email-thierry.reding@gmail.com>
References: <1374774810-18459-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1374774810-18459-14-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Beaver's PCIe lane configuration most closely matches x2 x2 x2 rather
than x4 x1 x1, since clocks 0 and 2 are used, and lanes 0 and 5 are used,
and the only way those align is with a x2 x2 x2 configuration.

Also, disable root port 1; there's nothing connected to it. Root port 0
is the on-board PCIe Ethernet, and port 2 is the mini-PCIe slot.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 4d9fa31..e1dd644 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -18,16 +18,16 @@
 
 		pci at 1,0 {
 			status = "okay";
-			nvidia,num-lanes = <4>;
+			nvidia,num-lanes = <2>;
 		};
 
 		pci at 2,0 {
-			status = "okay";
-			nvidia,num-lanes = <1>;
+			nvidia,num-lanes = <2>;
 		};
 
 		pci at 3,0 {
-			nvidia,num-lanes = <1>;
+			status = "okay";
+			nvidia,num-lanes = <2>;
 		};
 	};
 
-- 
1.8.1.5
