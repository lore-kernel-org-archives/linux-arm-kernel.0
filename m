From: rogerq@ti.com (Roger Quadros)
Date: Wed, 8 Jan 2014 11:45:38 +0530
Subject: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding information
In-Reply-To: <1389161742-10533-1-git-send-email-rogerq@ti.com>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com>
Message-ID: <1389161742-10533-2-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap-usb-host driver expects the 60MHz functional clock
of the USB host module to be named as "init_60m_fclk".
Add this information in the DT binding document.

CC: Lee Jones <lee.jones@linaro.org>
CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/mfd/omap-usb-host.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
index b381fa6..5635202 100644
--- a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
+++ b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
@@ -32,6 +32,10 @@ Optional properties:
 - single-ulpi-bypass: Must be present if the controller contains a single
   ULPI bypass control bit. e.g. OMAP3 silicon <= ES2.1
 
+- clocks: phandle to 60MHz functional clock to the USB Host module.
+
+- clock-names: must be "init_60m_fclk"
+
 Required properties if child node exists:
 
 - #address-cells: Must be 1
-- 
1.8.3.2
