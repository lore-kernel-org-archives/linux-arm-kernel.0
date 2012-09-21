From: wni@nvidia.com (Wei Ni)
Date: Fri, 21 Sep 2012 16:54:57 +0800
Subject: [PATCH v2 2/5] ARM: dt: t20 seaboard: turn on the power for wlan
In-Reply-To: <1348217700-12309-1-git-send-email-wni@nvidia.com>
References: <1348217700-12309-1-git-send-email-wni@nvidia.com>
Message-ID: <1348217700-12309-3-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the SDHCI1 controller. This is connected to the WiFi module.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra20-seaboard.dts |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index e60dc71..0ee474d 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -592,6 +592,12 @@
 		status = "okay";
 	};
 
+	sdhci at c8000000 {
+		status = "okay";
+		power-gpios = <&gpio 86 0>; /* gpio PK6 */
+		bus-width = <4>;
+	};
+
 	sdhci at c8000400 {
 		status = "okay";
 		cd-gpios = <&gpio 69 0>; /* gpio PI5 */
-- 
1.7.1
