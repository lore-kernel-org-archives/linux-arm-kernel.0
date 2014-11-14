From: l.majewski@samsung.com (Lukasz Majewski)
Date: Fri, 14 Nov 2014 11:03:25 +0100
Subject: [RESEND PATCH 2/2] ARM: dts: exynos4412-trats2: Enable TMU support at
 Trats2
In-Reply-To: <1415959405-14157-1-git-send-email-l.majewski@samsung.com>
References: <1381300194-13134-5-git-send-email-l.majewski@samsung.com>
 <1415959405-14157-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1415959405-14157-2-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables support for TMU at Exynos4412 based Trats2 board.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 5e066cd..121430d 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -551,6 +551,11 @@
 		status = "okay";
 	};
 
+	tmu at 100C0000 {
+		vtmu-supply = <&ldo10_reg>;
+		status = "okay";
+	};
+
 	i2c_ak8975: i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		gpios = <&gpy2 4 0>, <&gpy2 5 0>;
-- 
2.0.0.rc2
