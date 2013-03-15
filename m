From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Mar 2013 21:06:28 +0100
Subject: [PATCH 6/6] ARM: sunxi: hackberry: Add UART muxing
In-Reply-To: <1363377988-4966-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1363377988-4966-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1363377988-4966-7-git-send-email-maxime.ripard@free-electrons.com>
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
index f84549a..97703fe 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -24,6 +24,8 @@
 
 	soc {
 		uart0: uart at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
 	};
-- 
1.7.10.4
