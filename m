From: aford173@gmail.com (Adam Ford)
Date: Thu, 26 Apr 2018 21:24:09 -0500
Subject: [PATCH V2] ARM: dts: da850-evm: add WP and CD to MMC
Message-ID: <20180427022409.13105-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy mode uses the write protect and card detect but DT
has not.  This patch enables the pinmuxing and detection for
WP and CD.

Signed-off-by: Adam Ford <aford173@gmail.com>
---

V2:  Rebase on davinci master and remove GPIO pinmuxing

 arch/arm/boot/dts/da850-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 4c59dab3362e..a56d43d53ba1 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -107,6 +107,8 @@
 			status = "okay";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins>;
+			cd-gpios = <&gpio 64 GPIO_ACTIVE_LOW>;
+			wp-gpios = <&gpio 65 GPIO_ACTIVE_HIGH>;
 		};
 		spi1: spi at 30e000 {
 			status = "okay";
-- 
2.17.0
