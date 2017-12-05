From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Tue, 5 Dec 2017 15:06:44 +0100
Subject: [PATCH v2 3/5] rtc: mxc_v2: add driver for i.MX53 SRTC
In-Reply-To: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20171205140646.30367-4-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

Add RTC_DRV_MXC_V2 config option

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

---

To: Alessandro Zummo <a.zummo@towertech.it>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>

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
 drivers/rtc/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b59a31b079a5..440edebf5c71 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1689,6 +1689,16 @@ config RTC_DRV_MXC
 	   This driver can also be built as a module, if so, the module
 	   will be called "rtc-mxc".
 
+config RTC_DRV_MXC_V2
+	tristate "Freescale MXC Real Time Clock for i.MX53"
+	depends on ARCH_MXC
+	help
+	   If you say yes here you get support for the Freescale MXC
+	   SRTC module in i.MX53 processor.
+
+	   This driver can also be built as a module, if so, the module
+	   will be called "rtc-mxc_v2".
+
 config RTC_DRV_SNVS
 	tristate "Freescale SNVS RTC support"
 	select REGMAP_MMIO
-- 
2.11.0
