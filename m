From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Mon, 18 Dec 2017 12:51:30 +0100
Subject: [PATCH v4 1/4] dt-bindings: rtc: add bindings for i.MX53 SRTC
In-Reply-To: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
References: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20171218115133.16371-2-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

Document the binding for i.MX53 SRTC implemented by rtc-mxc_v2

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

---

v4:
- replace "srtc" node name with generic "rtc"

v2:
- added "Secure" and (SRTC) to the description

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-rtc at vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Cc: devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-kernel at vger.kernel.org (open list)
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Juergen Borleis <jbe@pengutronix.de>
Cc: Noel Vellemans <Noel.Vellemans@visionbms.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Cc: Russell King <linux@armlinux.org.uk> (maintainer:ARM PORT)
Cc: linux-arm-kernel at lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)

Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
---
 Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt b/Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt
new file mode 100644
index 000000000000..79d7e87b0d91
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt
@@ -0,0 +1,17 @@
+* i.MX53 Secure Real Time Clock (SRTC)
+
+Required properties:
+- compatible: should be: "fsl,imx53-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- clocks: should contain the phandle for the rtc clock
+- interrupts: rtc alarm interrupt
+
+Example:
+
+rtc at 53fa4000 {
+	compatible = "fsl,imx53-rtc";
+	reg = <0x53fa4000 0x4000>;
+	interrupts = <24>;
+	clocks = <&clks IMX5_CLK_SRTC_GATE>;
+};
-- 
2.11.0
