From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:55 +0200
Subject: [PATCH 35/41] ARM: dts: kzm9d: Update console parameters
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <20fc3188ac35f4afe52d24d02a0750c5e9307c98.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a "serial1" alias for the serial console (it is labeled "uart1").
Add the serial port config to "chosen/stdout-path", which requires
referring to the port by alias.
Drop the "console=" parameter from the kernel command line, as it's no
longer needed for DT-based platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 9eb86f8f32c5..60d0a732833a 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -23,9 +23,13 @@
 		reg = <0x40000000 0x8000000>;
 	};
 
+	aliases {
+		serial1 = &uart1;
+	};
+
 	chosen {
-		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
-		stdout-path = &uart1;
+		bootargs = "ignore_loglevel root=/dev/nfs ip=dhcp";
+		stdout-path = "serial1:115200n8";
 	};
 
 	gpio_keys {
-- 
2.7.0.rc3.207.g0ac5344
