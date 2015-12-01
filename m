From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue,  1 Dec 2015 20:03:17 +0200
Subject: [PATCH V3 15/19] ARM: dts: am57xx: sbc-am57x: add GPIO expander
 support
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448993001-19495-16-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCA9555 GPIO expander support (over I2C5 bus).

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---

  v3:

   * No fuctional changes
   * Reformat subject

  v2:

   * Fixed patch subject/description

 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index a3588ba..edce6c6 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -89,4 +89,11 @@
 		reg = <0x50>;
 		pagesize = <16>;
 	};
+
+	pca9555: pca9555 at 20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
1.9.1
