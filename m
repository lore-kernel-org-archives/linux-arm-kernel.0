From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Jul 2012 14:02:43 -0600
Subject: [PATCH 1/2] ARM: dt: tegra trimslice: enable USB2 port
Message-ID: <1343246564-21527-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This was accidentally disabled by commit 2a5fdc9 "ARM: dt: tegra:
invert status=disable vs status=okay".

Cc: <stable@vger.kernel.org> # v3.5 (file is named tegra-trimslice.dts there)
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-trimslice.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 9de5636..84a9523 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -279,6 +279,7 @@
 	};
 
 	usb at c5004000 {
+		status = "okay";
 		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
 	};
 
-- 
1.7.0.4
