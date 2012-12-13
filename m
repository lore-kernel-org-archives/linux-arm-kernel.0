From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 13 Dec 2012 13:22:08 +0000
Subject: [PATCH 6/8] ARM: ux500: Setup correct settling time for the MMCI
 regulator
In-Reply-To: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
References: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355404930-5691-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO controlled MMCI regulator used on the ux5x0 boards takes
100us to settle. There's already a binding to provide such
information. Let's make use of it.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 88f90217..208fe8b 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -638,6 +638,7 @@
 			regulator-name = "mmci-reg";
 			regulator-type = "voltage";
 
+			startup-delay-us = <100>;
 			enable-active-high;
 
 			states = <1800000 0x1
-- 
1.7.9.5
