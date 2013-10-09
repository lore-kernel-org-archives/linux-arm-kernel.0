From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 9 Oct 2013 17:20:11 +0800
Subject: [PATCH 7/7] ARM: tegra: enable LP1 suspend mode for Venice2
In-Reply-To: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381310411-11391-8-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable LP1 suspend mode for Tegra124 Venice2 board.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 279c7b5..2a3615b 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -20,6 +20,13 @@
 
 	pmc at 7000e400 {
 		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <1>;
+		nvidia,cpu-pwr-good-time = <500>;
+		nvidia,cpu-pwr-off-time = <300>;
+		nvidia,core-pwr-good-time = <641 3845>;
+		nvidia,core-pwr-off-time = <61036>;
+		nvidia,core-power-req-active-high;
+		nvidia,sys-clock-req-active-high;
 	};
 
 	clocks {
-- 
1.8.4
