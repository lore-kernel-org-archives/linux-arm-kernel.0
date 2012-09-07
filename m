From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Sep 2012 12:14:47 +0100
Subject: [PATCH 07/19] ARM: ux500: Add all encompassing sound node to the HREF
 Device Tree
In-Reply-To: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1347016499-29354-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is where we link together all of the SoC sound components for
a given platform. This all encompassing sound node is only found
in the very lowest hierarchical DTS file, since the component mix may
well change from board variant to board variant.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefv60plus.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 4f0aee8..d8ed29e 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -78,6 +78,13 @@
 			status = "okay";
 		};
 
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
