From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Sun, 13 Dec 2015 10:55:37 +0200
Subject: [PATCH 3/5] ARM: dts: cm-t335: add support for I2C GPIO expander
In-Reply-To: <1449996939-13901-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1449996939-13901-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1449996939-13901-4-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C GPIO expander (PCA9555) adds 16 GPIOs to the module.

Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am335x-sbc-t335.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-sbc-t335.dts b/arch/arm/boot/dts/am335x-sbc-t335.dts
index 9e98445..4a5177e 100644
--- a/arch/arm/boot/dts/am335x-sbc-t335.dts
+++ b/arch/arm/boot/dts/am335x-sbc-t335.dts
@@ -14,3 +14,14 @@
 	model = "CompuLab CM-T335 on SB-T335";
 	compatible = "compulab,sbc-t335", "compulab,cm-t335", "ti,am33xx";
 };
+
+&i2c0 {
+	/* GPIO extender */
+	gpio_ext: pca9555 at 26 {
+		compatible = "nxp,pca9555";
+		pinctrl-names = "default";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x26>;
+	};
+};
-- 
2.5.0
