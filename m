From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 14 Aug 2018 15:21:46 +0200
Subject: [PATCH v2 2/2] ARM: dts: imx6q-icore-mipi: Use 1.5 version of i.Core
 MX6
In-Reply-To: <1534252906-29554-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1534252906-29554-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1534252906-29554-3-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo@jmondi.org>

The "EDIMM STARTER KIT i.Core 1.5 MIPI Evaluation" is based on the 1.5 version
of the i.Core MX6 cpu module. The 1.5 version differs from the original one for
a few details, including the ethernet PHY interface clock provider.

With this commit, the ethernet interface works properly:
SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver

While before using the 1.5 version, ethernet failed to startup do to un-clocked
PHY interface:
fec 2188000.ethernet eth0: could not attach to PHY

Fixes: 3fe088357731 ("ARM: dts: imx6q: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support")
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 arch/arm/boot/dts/imx6q-icore-mipi.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-icore-mipi.dts b/arch/arm/boot/dts/imx6q-icore-mipi.dts
index 95b2efd..1f15882 100644
--- a/arch/arm/boot/dts/imx6q-icore-mipi.dts
+++ b/arch/arm/boot/dts/imx6q-icore-mipi.dts
@@ -8,10 +8,10 @@
 /dts-v1/;
 
 #include "imx6q.dtsi"
-#include "imx6qdl-icore.dtsi"
+#include "imx6qdl-icore-1.5.dtsi"
 
 / {
-	model = "Engicam i.CoreM6 Quad/Dual MIPI Starter Kit";
+	model = "Engicam i.CoreM6 1.5 Quad/Dual MIPI Starter Kit";
 	compatible = "engicam,imx6-icore", "fsl,imx6q";
 };
 
-- 
2.7.4
