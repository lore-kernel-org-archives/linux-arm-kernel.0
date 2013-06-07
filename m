From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri,  7 Jun 2013 16:37:15 +0530
Subject: [PATCH 3/3] ARM: dts: Set BUCK7 as always on for Origen board
In-Reply-To: <1370603235-11193-1-git-send-email-tushar.behera@linaro.org>
References: <1370603235-11193-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1370603235-11193-4-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LDO for LCD driver is currently not handled by any of the drivers.
This disables the LDO during booting time. To fix this, the LDO
is forced to enabled always.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/boot/dts/exynos4210-origen.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 4c6c3cd..08609b8 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -225,6 +225,7 @@
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
 					regulator-boot-on;
+					regulator-always-on;
 				};
 			};
 		};
-- 
1.7.9.5
