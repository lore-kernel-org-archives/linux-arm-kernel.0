From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  7 Mar 2013 23:14:20 +0100
Subject: [PATCH 6/6] ARM: sunxi: hackberry: Add UART muxing
In-Reply-To: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1362694460-1919-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We previously relied on the bootloader to do the muxing of the UART for
the Hackberry. Don't rely on it anymore and use pinctrl.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
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
