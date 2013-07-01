From: richard.genoud@gmail.com (Richard Genoud)
Date: Mon,  1 Jul 2013 10:39:30 +0200
Subject: [RFC PATCH 05/13] ARM: AT91: DTS: sam9x5ek: add WM8731 codec
In-Reply-To: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1372667978-4718-6-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The WM8731 codec on sam9x5ek board is on i2c, address 1A

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5ek.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index b753855..a81a1a6 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -59,6 +59,11 @@
 
 			i2c0: i2c at f8010000 {
 				status = "okay";
+
+				wm8731: wm8731 at 1a {
+					compatible = "wm8731";
+					reg = <0x1a>;
+				};
 			};
 
 			pinctrl at fffff400 {
-- 
1.7.10.4
