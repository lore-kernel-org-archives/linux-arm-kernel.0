From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 14 Jan 2015 17:21:59 +0100
Subject: [PATCH 07/12] usb: gadget: at91_udc: Document DT clocks and
 clock-names property
In-Reply-To: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421252524-24452-8-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

The at91_udc driver request 2 clocks, and thus need them to be defined in
the device tree.
Document the clocks and clock-names properties so that everybody use the
correct names.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/usb/atmel-usb.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index bc2222ca3f2a..6007231e0adc 100644
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
2.1.0
