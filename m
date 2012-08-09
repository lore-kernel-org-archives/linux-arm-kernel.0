From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Aug 2012 16:47:47 +0100
Subject: [PATCH 21/22] ARM: ux500: Add all encompassing sound node to the
 Snowball Device Tree
In-Reply-To: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344527268-5964-22-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is where we link together all of the SoC sound components for
a given platform. This all encompassing sound node is only found
in the very lowest hierarchical DTS file, since the component mix may
well change from board variant to board variant.

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
