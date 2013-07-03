From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Jul 2013 17:50:47 +0800
Subject: [PATCH V2 11/11] ARM: dts: tegra114: dalmore: add PM configurations
 for PMC
In-Reply-To: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
References: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
Message-ID: <1372845047-25147-12-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the PM configurations for PMC to support platform suspend.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change
---
 arch/arm/boot/dts/tegra114-dalmore.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index b97a8cc..625bf3a 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -850,6 +850,13 @@
 
 	pmc {
 		nvidia,invert-interrupt;
+		nvidia,suspend-mode = <2>;
+		nvidia,cpu-pwr-good-time = <500>;
+		nvidia,cpu-pwr-off-time = <300>;
+		nvidia,core-pwr-good-time = <641 3845>;
+		nvidia,core-pwr-off-time = <61036>;
+		nvidia,core-power-req-active-high;
+		nvidia,sys-clock-req-active-high;
 	};
 
 	ahub {
-- 
1.8.3.2
