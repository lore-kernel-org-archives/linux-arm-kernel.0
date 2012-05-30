From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:39 +0800
Subject: [PATCH 21/22] ARM: ux500: Enable probing of pinctrl through Device
 Tree
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-22-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nomadik GPIO controller now relies on Nomadik pinctrl, however
the pinctrl driver is not currently started by any ux500 platform.
This is requred or GPIOs do not work at all.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 1fa5546..4ad5160 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -170,6 +170,10 @@
 			gpio-bank = <8>;
 		};
 
+		pinctrl {
+			compatible = "stericsson,nmk_pinctrl";
+		};
+
 		usb at a03e0000 {
 			compatible = "stericsson,db8500-musb",
 				"mentor,musb";
-- 
1.7.9.5
