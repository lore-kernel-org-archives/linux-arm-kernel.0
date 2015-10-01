From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  1 Oct 2015 19:57:50 +0800
Subject: [PATCH v5 4/5] ARM: dts: sun8i: q8-common: Enable RSB controller for
 A23/A33 Q8 tablets
In-Reply-To: <1443700673-24312-1-git-send-email-wens@csie.org>
References: <1443700673-24312-1-git-send-email-wens@csie.org>
Message-ID: <1443700673-24312-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Reduced Serial Bus controller is used to talk to the onboard PMIC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v4:

  - Move enabling RSB controller from ippo-q8h-v5 dts to sun8i-q8-common

---
 arch/arm/boot/dts/sun8i-q8-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
index f34273602f64..1a69231d2da5 100644
--- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
@@ -90,6 +90,10 @@
 	};
 };
 
+&r_rsb {
+	status = "okay";
+};
+
 &r_uart {
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_uart_pins_a>;
-- 
2.5.3
