From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 10 Jan 2017 10:27:44 -0300
Subject: [PATCH 1/3] arm64: dts: Add missing unit name to Exynos7 SoC node
In-Reply-To: <1484054866-3988-1-git-send-email-javier@osg.samsung.com>
References: <1484054866-3988-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1484054866-3988-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following DTC warning about a mismatch
between a device node reg property and its unit name:

Node /soc has a reg or ranges property, but no unit name

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm64/boot/dts/exynos/exynos7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 80aa60e38237..0d2fedc6ac2f 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -69,7 +69,7 @@
 		method = "smc";
 	};
 
-	soc: soc {
+	soc: soc at 0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.7.4
