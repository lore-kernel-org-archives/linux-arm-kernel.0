From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  1 Aug 2012 12:10:36 -0300
Subject: [RFC] ARM: imx6q-sabrelite: Add CLKO IOMUX
Message-ID: <1343833836-14287-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

In order to have audio functional on mx6qsabrelite, it is necessary to setup
the IOMUX for MX6Q_PAD_GPIO_0__CCM_CLKO and MX6Q_PAD_GPIO_3__CCM_CLKO2 pins.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Dirk,

Not tested. If you have a chance to try it, please let me know.

 arch/arm/boot/dts/imx6q-sabrelite.dts |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index d42e851..f22c089 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -53,6 +53,8 @@
 						fsl,pins = <
 							   144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
 							   121  0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
+							   953  0x00000000	/* MX6Q_PAD_GPIO_0__CCM_CLKO */
+							   979  0x00000004	/* MX6Q_PAD_GPIO_3__CCM_CLKO2 */
 							   >;
 					};
 				};
-- 
1.7.1
