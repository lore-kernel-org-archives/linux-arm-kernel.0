From: linux.amoon@gmail.com (Anand Moon)
Date: Sun, 11 Oct 2015 15:46:02 +0000
Subject: [PATCH 1/3] ARM: dts: exynos5422-odroidxu3: use cd-gpio method to
 detect sd-card
Message-ID: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaehoon Chung <jh80.chung@samsung.com>

To detect sd-card use the cd-gpio method.
It can decrease the interrupt for detecting sd-card.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>

---
Changes based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v4.4-next/dt-samsung branch
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 1af5bdc..26decbd 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -352,8 +352,10 @@
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
 	samsung,dw-mshc-ddr-timing = <0 2>;
+	cd-gpios = <&gpc2 2 GPIO_ACTIVE_HIGH>;
+	cd-inverted;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 	bus-width = <4>;
 	cap-sd-highspeed;
 };
-- 
2.1.4
