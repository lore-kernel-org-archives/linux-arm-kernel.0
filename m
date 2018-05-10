From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  9 May 2018 23:08:09 -0300
Subject: [PATCH 3/3] ARM: dts: imx6q-gk802: Do not hardcode input codes
In-Reply-To: <1525918089-26242-1-git-send-email-festevam@gmail.com>
References: <1525918089-26242-1-git-send-email-festevam@gmail.com>
Message-ID: <1525918089-26242-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Instead of hardcoding the input codes we can use the symbol name for
better readability.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6q-gk802.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-gk802.dts b/arch/arm/boot/dts/imx6q-gk802.dts
index 0be3756..84d3540 100644
--- a/arch/arm/boot/dts/imx6q-gk802.dts
+++ b/arch/arm/boot/dts/imx6q-gk802.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "imx6q.dtsi"
 
 / {
@@ -43,7 +44,7 @@
 		recovery-button {
 			label = "recovery";
 			gpios = <&gpio3 16 1>;
-			linux,code = <0x198>; /* KEY_RESTART */
+			linux,code = <KEY_RESTART>;
 			wakeup-source;
 		};
 	};
-- 
2.7.4
