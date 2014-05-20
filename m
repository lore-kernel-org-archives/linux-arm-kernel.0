From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 May 2014 16:09:27 -0500
Subject: [PATCH 01/10] dt/bindings: add passthru-mask property to
 versatile-fpga-irq
In-Reply-To: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
Message-ID: <1400620176-7239-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Add a passthru-mask property for setting interrupts which are passed
through directly to a primary controller.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt b/Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt
index c9cf605..956b71d 100644
--- a/Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt
+++ b/Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt
@@ -34,3 +34,6 @@ Optional properties:
 - interrupts: if the FPGA IRQ controller is cascaded, i.e. if its IRQ
   output is simply connected to the input of another IRQ controller,
   then the parent IRQ shall be specified in this property.
+- passthru-mask: a u32 number representing a bit mas determining which of
+  the interrupts are directly passed through to the primary interrupt
+  controller.
-- 
1.9.1
