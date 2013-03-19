From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Mar 2013 11:35:16 +0100
Subject: [PATCH 7/7] ARM: sunxi: hackberry: Add UART muxing
In-Reply-To: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1363689316-7847-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We previously relied on the bootloader to do the muxing of the UART for
the Hackberry. Don't rely on it anymore and use pinctrl.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun4i-a10-hackberry.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index 9ab6875..2046000 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -24,6 +24,8 @@
 
 	soc {
 		uart0: serial at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
 	};
-- 
1.7.10.4
