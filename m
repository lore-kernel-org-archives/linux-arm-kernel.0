From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  8 Dec 2015 18:54:13 +0100
Subject: [PATCH 08/13] ARM: shmobile: kzm9d dts: Update console parameters
In-Reply-To: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1449597258-32623-9-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a "serial1" alias for the serial console (it's labeled "uart1").
Drop the "console=" parameter from the kernel command line, as it's no
longer needed for DT-based platforms.
Add the serial port config to chosen/stdout-path.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 8c24975e8f9d6638..191b565449509778 100644
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
1.9.1
