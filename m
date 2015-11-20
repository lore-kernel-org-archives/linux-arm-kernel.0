From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:08 -0800
Subject: [PATCH 01/29] ARM: shmobile: porter: add HS-USB DT support
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <c794f6a09a251e229b122082eff1f85b994d2bca.1447981420.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Enable HS-USB device  for the Porter board, defining the GPIO that the
driver should check  when probing (which is the ID output from MAX3355
OTG chip).

Note that there  will be pinctrl-related error messages if both internal
PCI  and  HS-USB drivers are enabled but they should be just ignored.

This patch is  analogous  to the commit 6f4f7156e0e6 ("ARM: shmobile:
henninger: enable HS-USB") as there  are no differences between the
boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index fe0f12fc02a1..9f9ffe322d17 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -269,6 +269,14 @@
 	status = "okay";
 };
 
+&hsusb {
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	renesas,enable-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
+};
+
 &usbphy {
 	status = "okay";
 };
-- 
2.1.4
