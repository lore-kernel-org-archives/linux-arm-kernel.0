From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  3 Dec 2014 12:32:02 +0100
Subject: [PATCH 03/11] usb: gadget: at91_udc: Document DT clocks and
 clock-names property
In-Reply-To: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1417606330-17753-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at91_udc driver request 2 clocks, and thus need them to be defined in
the device tree.
Document the clocks and clock-names properties so that everybody use the
correct names.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/usb/atmel-usb.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index bc2222c..6007231 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -36,6 +36,10 @@ Required properties:
  - compatible: Should be "atmel,at91rm9200-udc"
  - reg: Address and length of the register set for the device
  - interrupts: Should contain macb interrupt
+ - clocks: Should reference the peripheral and the AHB clocks
+ - clock-names: Should contains two strings
+		"pclk" for the peripheral clock
+		"hclk" for the AHB clock
 
 Optional properties:
  - atmel,vbus-gpio: If present, specifies a gpio that needs to be
-- 
1.9.1
