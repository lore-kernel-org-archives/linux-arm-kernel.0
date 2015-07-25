From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 25 Jul 2015 11:22:03 +0200
Subject: [PATCH] ARM: nomadik: disable UART0 on Nomadik boards
Message-ID: <1437816123-7692-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART0 is not used on these boards, yet active and blocking
other use. Fix this by disabling UART0 and setting port aliases
to maintain port enumeration to userspace.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly to fixes if you're
OK with it.
---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts    | 1 +
 arch/arm/boot/dts/ste-nomadik-s8815.dts    | 4 ++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index 3d0b8755caee..3d25dba143a5 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -17,6 +17,7 @@
 	};
 
 	aliases {
+		serial1 = &uart1;
 		stmpe-i2c0 = &stmpe0;
 		stmpe-i2c1 = &stmpe1;
 	};
diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index 85d3b95dfdba..3c140d05f796 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -15,6 +15,10 @@
 		bootargs = "root=/dev/ram0 console=ttyAMA1,115200n8 earlyprintk";
 	};
 
+	aliases {
+		serial1 = &uart1;
+	};
+
 	src at 101e0000 {
 		/* These chrystal drivers are not used on this board */
 		disable-sxtalo;
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 6846e3eb027d..8e601d02ca8c 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -763,6 +763,7 @@
 			clock-names = "uartclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_default_mux>;
+			status = "disabled";
 		};
 
 		uart1: uart at 101fb000 {
-- 
2.4.3
