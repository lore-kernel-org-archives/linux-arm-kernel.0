From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Dec 2012 08:55:59 +0000
Subject: [PATCH 10/12] ARM: ux500: Setup correct settling time for the MMCI
 regulator
In-Reply-To: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355129761-8088-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO controlled MMCI regulator used on the ux5x0 boards takes
100us to settle. There's already a binding to provide such
information. Let's make use of it.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 0523681..2337b74 100644
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
