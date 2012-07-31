From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 14:39:10 +0100
Subject: [PATCH 16/19] ARM: ux500: Add all encompassing sound node to the
 Snowball Device Tree
In-Reply-To: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343741953-17828-17-git-send-email-lee.jones@linaro.org>
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
