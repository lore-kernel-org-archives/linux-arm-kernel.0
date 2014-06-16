From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 16 Jun 2014 19:56:44 +0200
Subject: [PATCH v2 1/4] dt: bindings: add bindings for Broadcom bcm43xx sdio
 devices
In-Reply-To: <1402941407-8210-1-git-send-email-hdegoede@redhat.com>
References: <1402941407-8210-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1402941407-8210-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arend van Spriel <arend@broadcom.com>

The Broadcom bcm43xx sdio devices are fullmac devices that may be
integrated in ARM platforms. Currently, the brcmfmac driver for
these devices support use of platform data. This patch specifies
the bindings that allow this platform data to be expressed in the
devicetree.

Reviewed-by: Hante Meuleman <meuleman@broadcom.com>
Reviewed-by: Franky (Zhenhui) Lin <frankyl@broadcom.com>
Reviewed-by: Daniel (Deognyoun) Kim <dekim@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieterpg@broadcom.com>
Signed-off-by: Arend van Spriel <arend@broadcom.com>
[hdegoede at redhat.com: drop clk / reg_on gpio handling, as there is no consensus
 on how to handle this yet]
[hdegoede at redhat.com: move from bindings/staging to bindings]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../bindings/net/wireless/brcm,bcm43xx-fmac.txt    | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
new file mode 100644
index 0000000..6a0aaf2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
@@ -0,0 +1,29 @@
+Broadcom BCM43xx Fullmac wireless SDIO devices
+
+This node provides properties for controlling the Broadcom wireless device. The
+node is expected to be specified as a child node to the SDIO controller that
+connects the device to the system.
+
+Required properties:
+
+ - compatible : Should be "brcm,bcm43xx-fmac".
+
+Optional properties:
+ - brcm,drive-strength : drive strength used for SDIO pins on device.
+	(default = 6mA).
+ - interrupt-parent : the phandle for the interrupt controller to which the
+	device interrupts are connected.
+ - interrupts : specifies attributes for the out-of-band interrupt (host-wake).
+	When not specified the device will use in-band SDIO interrupts.
+ - interrupt-names : name of the out-of-band interrupt, which must be set
+	to "host-wake".
+
+Example:
+
+bcm4335 {
+	compatible = "brcm,bcm43xx-fmac";
+	brcm,drive-strength = <4>;
+	interrupt-parent = <&gpx2>;
+	interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "host-wake";
+};
-- 
2.0.0
