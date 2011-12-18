From: swarren@nvidia.com (Stephen Warren)
Date: Sat, 17 Dec 2011 22:28:21 -0700
Subject: [PATCH 3/3] arm/dt: Add ADT7461 to Seaboard
In-Reply-To: <1324186101-23695-1-git-send-email-swarren@nvidia.com>
References: <1324186101-23695-1-git-send-email-swarren@nvidia.com>
Message-ID: <1324186101-23695-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ADT7461 is a temperature monitoring IC. One is present on the DVC
I2C bus on Seaboard.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
For this to be useful, the previous two patches are required. Without
them, all the I2C transactions to this device will time out and spew
errors, but other device shouldn't be affected.

 arch/arm/boot/dts/tegra-seaboard.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index 3cfbd04..b55a02e 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -25,6 +25,11 @@
 
 	i2c at 7000d000 {
 		clock-frequency = <400000>;
+
+		adt7461 at 4c {
+			compatible = "adt7461";
+			reg = <0x4c>;
+		};
 	};
 
 	serial at 70006000 {
-- 
1.7.5.4
