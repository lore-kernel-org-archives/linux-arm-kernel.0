From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Apr 2016 23:34:27 -0300
Subject: [PATCH] ARM: dts: imx6sx-sdb: Add 198MHz operational point
Message-ID: <1461897267-20458-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx6sx-sdb has custom operating points entries because it has one
power supply that drives both VDDARM_IN and VDDSOC_IN.

As per the MX6UL datasheet we have the following minimum voltages for
198 MHz operation (after adding the 25mV margin value):
VDDARM_IN = 0.975 V
VDDSOC_IN = 1.175 V

So use 1.175V for the 198MHz operation.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 0ad164a..5bb8fd5 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -18,12 +18,14 @@
 		996000  1250000
 		792000  1175000
 		396000  1175000
+		198000  1175000
 		>;
 	fsl,soc-operating-points = <
 		/* ARM kHz      SOC uV */
 		996000	1250000
 		792000	1175000
 		396000	1175000
+		198000  1175000
 	>;
 };
 
-- 
1.9.1
