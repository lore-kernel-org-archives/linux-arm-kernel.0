From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue,  1 Dec 2015 15:55:05 +0200
Subject: [PATCH V2 10/14] ARM: dts: am437x: cm-t43: add pca9555 support
In-Reply-To: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
References: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
Message-ID: <1448978109-5614-11-git-send-email-nikita@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SB-SOM comes with a PCA9555 GPIO extender. On SBC-T43 this resides on the
i2c1 bus. Add it to the device tree.

Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
---
Changes in V2:
	- No changes.

 arch/arm/boot/dts/am437x-sbc-t43.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sbc-t43.dts b/arch/arm/boot/dts/am437x-sbc-t43.dts
index 3fc824a..c7a1414 100644
--- a/arch/arm/boot/dts/am437x-sbc-t43.dts
+++ b/arch/arm/boot/dts/am437x-sbc-t43.dts
@@ -54,6 +54,13 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
+
+	pca9555: pca9555 at 20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &i2c2 {
-- 
1.9.1
