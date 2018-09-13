From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 13:12:30 -0500
Subject: [PATCH] ARM: dts: brcm: Fix SPI bus warnings
Message-ID: <20180913181245.25484-6-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc has new checks for SPI buses. Fix the warnings in node names.

arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dtb: Warning (spi_bus_bridge): /axi at 18000000/qspi at 27200: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958525er.dtb: Warning (spi_bus_bridge): /axi/qspi at 27200: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958525xmc.dtb: Warning (spi_bus_bridge): /axi/qspi at 27200: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958622hr.dtb: Warning (spi_bus_bridge): /axi/qspi at 27200: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958625hr.dtb: Warning (spi_bus_bridge): /axi/qspi at 27200: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm988312hr.dtb: Warning (spi_bus_bridge): /axi/qspi at 27200: node name for SPI buses should be 'spi'

Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please apply to the sub-arch tree. The dtc changes haven't landed, but 
will for 4.20.

 arch/arm/boot/dts/bcm-hr2.dtsi | 2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index 3084a7c95733..e4d49731287f 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -216,7 +216,7 @@
 			reg = <0x33000 0x14>;
 		};
 
-		qspi: qspi at 27200 {
+		qspi: spi at 27200 {
 			compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
 			reg = <0x027200 0x184>,
 			      <0x027000 0x124>,
diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 09ba85046322..2b219addeb44 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -273,7 +273,7 @@
 			brcm,nand-has-wp;
 		};
 
-		qspi: qspi at 27200 {
+		qspi: spi at 27200 {
 			compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
 			reg = <0x027200 0x184>,
 			      <0x027000 0x124>,
-- 
2.17.1
