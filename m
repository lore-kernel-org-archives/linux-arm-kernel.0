From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 10 Jul 2012 10:08:09 +0300
Subject: [PATCH 3/6] ARM: apx4devkit: fix the bus-width of SSP0 to 4 bits
In-Reply-To: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <1341904092-13777-4-git-send-email-lauri.hintsala@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
---
 arch/arm/boot/dts/apx4devkit.dts |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/apx4devkit.dts b/arch/arm/boot/dts/apx4devkit.dts
index 6217297..f6d1a57 100644
--- a/arch/arm/boot/dts/apx4devkit.dts
+++ b/arch/arm/boot/dts/apx4devkit.dts
@@ -20,10 +20,8 @@
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx28-mmc";
 				pinctrl-names = "default";
-				pinctrl-0 = <&mmc0_8bit_pins_a
-					     &mmc0_cd_cfg
-					     &mmc0_sck_cfg>;
-				bus-width = <8>;
+				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_sck_cfg>;
+				bus-width = <4>;
 				status = "okay";
 			};
 
-- 
1.7.9.5
