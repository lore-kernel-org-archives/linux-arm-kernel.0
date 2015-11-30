From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Mon, 30 Nov 2015 16:28:52 +0200
Subject: [PATCH v2 15/18] ARM: am57xx: sbc-am57x: dts: add GPIO expander
 support
In-Reply-To: <1448433590-1399-16-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-16-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448893732-851-1-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCA9555 GPIO expander support (over I2C5 bus).

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
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
