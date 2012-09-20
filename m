From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:12:42 +0200
Subject: [PATCH 24/32] ARM: ux500: Add all encompassing sound node to the
 Snowball Device Tree
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348143170-2130-25-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is where we link together all of the SoC sound components for
a given platform. This all encompassing sound node is only found
in the very lowest hierarchical DTS file, since the component mix may
well change from board variant to board variant.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index fce4a00..2969997 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -83,6 +83,14 @@
 	};
 
 	soc-u9500 {
+
+		sound {
+			compatible = "stericsson,snd-soc-mop500";
+
+			stericsson,cpu-dai = <&msp1 &msp3>;
+			stericsson,audio-codec = <&codec>;
+		};
+
 		msp1: msp at 80124000 {
 			status = "okay";
 		};
-- 
1.7.9.5
