From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 23 Jan 2015 15:48:24 +0800
Subject: [PATCH 1/2] ARM: exynos5440-sd5v1: switch to fixed-link DT binding
In-Reply-To: <1421999305-19267-1-git-send-email-ming.lei@canonical.com>
References: <1421999305-19267-1-git-send-email-ming.lei@canonical.com>
Message-ID: <1421999305-19267-2-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous dts property isn't standard way for fixed phy
support, and switch to the fixed-link DT binding.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/boot/dts/exynos5440-sd5v1.dts |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440-sd5v1.dts b/arch/arm/boot/dts/exynos5440-sd5v1.dts
index 268609a..ee65a5c 100644
--- a/arch/arm/boot/dts/exynos5440-sd5v1.dts
+++ b/arch/arm/boot/dts/exynos5440-sd5v1.dts
@@ -28,8 +28,10 @@
 	};
 
 	gmac: ethernet at 00230000 {
-		fixed_phy;
-		phy_addr = <1>;
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+		};
 	};
 
 	spi {
-- 
1.7.9.5
