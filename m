From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Sun, 10 Jun 2018 16:15:49 +0200
Subject: [PATCH 1/1] ARM: dts: s5pv210: Add missing interrupt-controller
 property to gph2
Message-ID: <1528640149-2195-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds missing interrupt-controller property to gph2 block,
to silence following warnings during build
  /soc/pinctrl at e0200000/gph2: Missing interrupt-controller or interrupt-map property

Observed on not yet mainlined, an S5PV210 based
Samsung Galaxy S (i9000) phone.

Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index 3a79feab11c3..7f0c9d447871 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -258,6 +258,8 @@
 	gph2: gph2 {
 		gpio-controller;
 		#gpio-cells = <2>;
+
+		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-- 
2.7.4
