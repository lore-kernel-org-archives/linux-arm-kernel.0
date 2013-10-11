From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 11 Oct 2013 17:58:39 +0800
Subject: [PATCH V2 4/4] ARM: tegra: enable LP1 suspend mode for Venice2
In-Reply-To: <1381485519-4027-1-git-send-email-josephl@nvidia.com>
References: <1381485519-4027-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381485519-4027-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable LP1 suspend mode for Tegra124 Venice2 board.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change
---
 arch/arm/boot/dts/tegra124-venice2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 5859ec2..a0b0283 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -16,6 +16,13 @@
 
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
