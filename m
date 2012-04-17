From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 17 Apr 2012 11:40:01 +0530
Subject: [PATCH V1 1/2] ARM: dt: tegra_cardhu: als and proximity sensor
 isl29028 support
In-Reply-To: <1334643002-6337-1-git-send-email-ldewangan@nvidia.com>
References: <1334643002-6337-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1334643002-6337-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device info for ALS and proximity sensor isl29028.
This device is connected on i2c2 bus.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra-cardhu.dts |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
index ab8d901..30cbd14 100644
--- a/arch/arm/boot/dts/tegra-cardhu.dts
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -93,6 +93,12 @@
 
 	i2c at 7000c500 {
 		clock-frequency = <100000>;
+
+		/* ALS and Proximity sensor */
+		isl29028: isl29028 at 44 {
+			compatible = "isl,isl29028";
+			reg = <0x44>;
+		};
 	};
 
 	i2c at 7000c700 {
-- 
1.7.1.1
