From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:54:38 +0900
Subject: [PATCH 12/29] ARM: shmobile: koelsch: fixup I2C2 clock frequency
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
Message-ID: <a8d943ed902bdbef05b64b7ad7ed8878a967a286.1416476366.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Koelsch I2C2 has 400kHz settings,
but, ak4643 audio codec chip which is connected to I2C2 can't
work such frequency.
Fixup I2C2 clock frequency to 100kHz.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 191f32b..59e4251 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -425,7 +425,7 @@
 	pinctrl-names = "default";
 
 	status = "okay";
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 
 	composite-in at 20 {
 		compatible = "adi,adv7180";
-- 
2.1.1
