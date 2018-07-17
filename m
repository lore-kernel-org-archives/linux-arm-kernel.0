From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Jul 2018 23:08:45 -0300
Subject: [PATCH] ARM: dts: imx6ul-pico-hobbit: Do not hardcode the memory size
Message-ID: <1531793325-12639-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

There are two variants of imx6ul-pico boards: one with 256MB and
another one with 512MB of RAM.

Do not hardcode the memory size in the device tree and let the
bootloader fill the correct value instead.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 47682b8..0c09420f 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -51,8 +51,9 @@
 	model = "Technexion Pico i.MX6UL Board";
 	compatible = "technexion,imx6ul-pico-hobbit", "fsl,imx6ul";
 
+	/* Will be filled by the bootloader */
 	memory at 80000000 {
-		reg = <0x80000000 0x10000000>;
+		reg = <0x80000000 0>;
 	};
 
 	chosen {
-- 
2.7.4
