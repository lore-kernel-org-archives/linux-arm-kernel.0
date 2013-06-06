From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  6 Jun 2013 13:16:55 +0100
Subject: [PATCH 07/33] ARM: ux500: Supply the Ethernet clock lookup to
 Snowball's DT
In-Reply-To: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370521041-32318-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index fb9dce5..e20e8ae 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -110,12 +110,13 @@
 				vdd33a-supply = <&en_3v3_reg>;
 				vddvario-supply = <&db8500_vape_reg>;
 
-
 				reg-shift = <1>;
 				reg-io-width = <2>;
 				smsc,force-internal-phy;
 				smsc,irq-active-high;
 				smsc,irq-push-pull;
+
+				clocks = <&prcc_pclk 3 0>;
 			};
 		};
 
-- 
1.7.10.4
