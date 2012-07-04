From: wni@nvidia.com (Wei Ni)
Date: Wed, 4 Jul 2012 17:34:45 +0800
Subject: [PATCH 2/5] ARM: dt: t20 seaboard: add pinmux, gpio for wlan
In-Reply-To: <1341394488-13169-1-git-send-email-wni@nvidia.com>
References: <1341394488-13169-1-git-send-email-wni@nvidia.com>
Message-ID: <1341394488-13169-3-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds wlan pinmux and gpio settings to the Tegra20 Seaboard device tree.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra20-seaboard.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 85e621a..f377a61 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -440,6 +440,11 @@
 		status = "okay";
 	};
 
+	sdhci at c8000000 {
+		status = "okay";
+		power-gpios = <&gpio 86 0>; /* gpio PK6 */
+	};
+
 	sdhci at c8000400 {
 		status = "okay";
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
-- 
1.7.1
