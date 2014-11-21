From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:54:32 +0900
Subject: [PATCH 06/29] ARM: shmobile: lager: fixup IIC2 clock frequency
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
Message-ID: <177d8bea33899cef3989a2d0b4ea7213b5f34d0a.1416476366.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Lager IIC2 is using default clock frequency,
but, ak4643 audio codec chip needs 100kHz
This patch clarifies IIC2 clock frequency as 100kHz.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 830f2e8..86fb2ee 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -429,6 +429,8 @@
 	pinctrl-0 = <&iic2_pins>;
 	pinctrl-names = "default";
 
+	clock-frequency = <100000>;
+
 	composite-in at 20 {
 		compatible = "adi,adv7180";
 		reg = <0x20>;
-- 
2.1.1
