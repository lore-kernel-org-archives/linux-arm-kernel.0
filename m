From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 17 Apr 2012 12:15:55 +0530
Subject: [PATCH 3/3] ARM: dt: tegra_ventana: als and proximity sensor isl29018
 support
In-Reply-To: <1334645155-13799-1-git-send-email-ldewangan@nvidia.com>
References: <1334645155-13799-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1334645155-13799-4-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device info for ALS and proximity sensor isl29018.
This device is connected on i2c0 bus.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra-ventana.dts |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index 71eb2e5..dd474e1 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -256,6 +256,12 @@
 			micdet-delay = <100>;
 			gpio-cfg = < 0xffffffff 0xffffffff 0 0xffffffff 0xffffffff >;
 		};
+
+		/* ALS and proximity sensor */
+		isl29018: isl29018 at 44 {
+			compatible = "isl,isl29018";
+			reg = <0x44>;
+		};
 	};
 
 	i2c at 7000c400 {
-- 
1.7.1.1
