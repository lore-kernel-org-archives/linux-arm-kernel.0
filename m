From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Dec 2014 13:28:31 -0600
Subject: [PATCH 2/9] dts: versatile: add PCI controller binding
In-Reply-To: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
Message-ID: <1419967718-26909-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Add the PCI controller node for the Versatile/PB board.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/versatile-pb.dts | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index e36c1e8..b83137f 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -29,6 +29,43 @@
 			clock-names = "apb_pclk";
 		};
 
+		pci-controller at 10001000 {
+			compatible = "arm,versatile-pci";
+			device_type = "pci";
+			reg = <0x10001000 0x1000
+			       0x41000000 0x10000
+			       0x42000000 0x100000>;
+			bus-range = <0 0xff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+
+			ranges = <0x01000000 0 0x00000000 0x43000000 0 0x00010000   /* downstream I/O */
+				  0x02000000 0 0x50000000 0x50000000 0 0x10000000   /* non-prefetchable memory */
+				  0x42000000 0 0x60000000 0x60000000 0 0x10000000>; /* prefetchable memory */
+
+			interrupt-map-mask = <0x1800 0 0 7>;
+			interrupt-map = <0x1800 0 0 1 &sic 28
+					 0x1800 0 0 2 &sic 29
+					 0x1800 0 0 3 &sic 30
+					 0x1800 0 0 4 &sic 27
+
+					 0x1000 0 0 1 &sic 27
+					 0x1000 0 0 2 &sic 28
+					 0x1000 0 0 3 &sic 29
+					 0x1000 0 0 4 &sic 30
+
+					 0x0800 0 0 1 &sic 30
+					 0x0800 0 0 2 &sic 27
+					 0x0800 0 0 3 &sic 28
+					 0x0800 0 0 4 &sic 29
+
+					 0x0000 0 0 1 &sic 29
+					 0x0000 0 0 2 &sic 30
+					 0x0000 0 0 3 &sic 27
+					 0x0000 0 0 4 &sic 28>;
+		};
+
 		fpga {
 			uart at 9000 {
 				compatible = "arm,pl011", "arm,primecell";
-- 
2.1.0
