From: sjg@chromium.org (Simon Glass)
Date: Fri,  3 Feb 2012 08:56:10 -0800
Subject: [PATCH 1/3] arm: tegra: dts: Support host/device selection and legacy
 mode
In-Reply-To: <1328288172-8059-1-git-send-email-sjg@chromium.org>
References: <1328288172-8059-1-git-send-email-sjg@chromium.org>
Message-ID: <1328288172-8059-2-git-send-email-sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some USB ports can support host and device operation. We add the dr_mode
property (as found in Freescale) for this.

One USB port has a 'legacy mode', left over from the days of pre-Tegra
chips. I don't believe this is actually used, except that we must know
to turn this off in the driver.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
 .../devicetree/bindings/usb/tegra-usb.txt          |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/tegra-usb.txt b/Documentation/devicetree/bindings/usb/tegra-usb.txt
index 035d63d..007005d 100644
--- a/Documentation/devicetree/bindings/usb/tegra-usb.txt
+++ b/Documentation/devicetree/bindings/usb/tegra-usb.txt
@@ -11,3 +11,16 @@ Required properties :
  - phy_type : Should be one of "ulpi" or "utmi".
  - nvidia,vbus-gpio : If present, specifies a gpio that needs to be
    activated for the bus to be powered.
+
+Optional properties:
+  - dr_mode : dual role mode. Indicates the working mode for
+   nvidia,tegra20-ehci compatible controllers.  Can be "host", "peripheral",
+   or "otg".  Default to "host" if not defined for backward compatibility.
+      host means this is a host controller
+      peripheral means it is device controller
+      otg means it can operate as either ("on the go")
+  - nvidia,has-legacy-mode : boolean indicates whether this controller can
+    operate in legacy mode (as APX 2500 / 2600). In legacy mode some
+    registers are accessed through the APB_MISC base address instead of
+    the USB controller. Since this is a legacy issue it probably does not
+    warrant a compatible string of its own.
-- 
1.7.7.3
