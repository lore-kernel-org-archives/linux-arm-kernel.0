From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Jul 2012 13:46:01 +0100
Subject: [PATCH 17/18] ARM: ux500: Add all encompassing Sound node to DB8500
 Device Tree
In-Reply-To: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343393162-11938-18-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the node which links together the platform (PCM), codec (AB8500)
and the CPU side Digital Audio Interface (MCP) with the machine driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index b9d4405..9d0fba6 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -595,6 +595,14 @@
 			compatible = "stericsson,ux500-pcm";
 		};
 
+		sound {
+			compatible = "stericsson,snd-soc-mop500";
+
+			stericsson,platform-pcm-dma = <&pcm>;
+			stericsson,cpu-dai = <&msp1 &msp3>;
+			stericsson,audio-codec = <&codec>;
+		};
+
 		msp0: msp at 80123000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80123000 0x1000>;
-- 
1.7.9.5
