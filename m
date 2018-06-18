From: manu@freebsd.org (Emmanuel Vadot)
Date: Mon, 18 Jun 2018 17:42:57 +0200
Subject: [PATCH] ARM: dts: imx6: RIoTboard Add chosen stdout-path property
Message-ID: <20180618154257.16919-1-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RIoTboard debug uart is connected to serial1.
Add a chosen property in the DTS so OS knows what serial port to use for
the console.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/imx6dl-riotboard.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 2e98c92adff7..315d2ae6fa45 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -19,6 +19,10 @@
 		reg = <0x10000000 0x40000000>;
 	};
 
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.17.0
