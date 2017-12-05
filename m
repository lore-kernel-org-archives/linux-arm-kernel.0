From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Tue, 5 Dec 2017 15:06:43 +0100
Subject: [PATCH v2 2/5] ARM: dts: imx53: add srtc node
In-Reply-To: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20171205140646.30367-3-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

rtc-mxc_v2 driver will add support for the i.MX53 SRTC

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

---

To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <kernel@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)

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
Cc: Russell King <linux@armlinux.org.uk> (maintainer:ARM PORT)
Cc: linux-arm-kernel at lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)

Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 589a67c5f796..e4ca9d9ba2fe 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -434,12 +434,10 @@
 			};
 
 			srtc: srtc at 53fa4000 {
-				compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
+				compatible = "fsl,imx53-rtc";
 				reg = <0x53fa4000 0x4000>;
 				interrupts = <24>;
-				interrupt-parent = <&tzic>;
 				clocks = <&clks IMX5_CLK_SRTC_GATE>;
-				clock-names = "ipg";
 			};
 
 			iomuxc: iomuxc at 53fa8000 {
-- 
2.11.0
