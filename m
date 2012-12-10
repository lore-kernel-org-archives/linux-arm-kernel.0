From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Dec 2012 08:55:55 +0000
Subject: [PATCH 06/12] ARM: ux500: Set correct MMCI regulator voltages in the
 ux5x0 Device Tree
In-Reply-To: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355129761-8088-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The voltages for the MMCI GPIO controlled voltage regulation differ
depending on who you believe and where you pick the information up
from. More recent internal code suggests that the true upper voltage
from the shifter is actually v3.3, instead of the previously
indicated v2.9. Let's mirror that change in the Device Tree file.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 9f55363..bbea89a 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -634,12 +634,12 @@
 			compatible = "regulator-gpio";
 
 			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2600000>;
+			regulator-max-microvolt = <3300000>;
 			regulator-name = "mmci-reg";
 			regulator-type = "voltage";
 
 			states = <1800000 0x1
-				  2900000 0x0>;
+				  3300000 0x0>;
 
 			status = "disabled";
 		};
-- 
1.7.9.5
