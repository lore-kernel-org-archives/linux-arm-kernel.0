From: sunil.m@techveda.org (sunil.m at techveda.org)
Date: Mon, 11 Sep 2017 12:00:16 +0530
Subject: [RESEND PATCH] arm: dts: am33xx: Add spi alias to match SOC schematics
Message-ID: <1505111416-21594-1-git-send-email-sunil.m@techveda.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suniel Mahesh <sunil.m@techveda.org>

Linux bus numbers should match the numbers defined by the chip
manufacturer. This patch add's spi aliases to acheive that bus
naming convention.

Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
Signed-off-by: Karthik Tummala <karthik@techveda.org>
Tested-by: Karthik Tummala <karthik@techveda.org>
---
Note:
- Patch was compile tested and built(ARCH=arm) on next-20170911.
- Patch was hardware tested on AM335x (McSPI controller) with
  spi flash chips.
- No build/run-time issues reported.
- At present bus numbers are represented as spi1 and spi2 in sysfs
  instead of spi0 and spi1, as defined in SOC schematics.
- The commit:
"spi: Pick spi bus number from Linux idr or spi alias"
(SHA1:9b61e302210eba55768962f2f11e96bb508c2408)
has introduced bus numbering which happens dynamically either
via Linux IDR or spi alias for master drivers.
- The commit:
"spi: omap: Allocate bus number from spi framework"
(SHA1:b590782afe0a99fca84f451252ed7e2d64b2f155)
is now using spi framework to allocate bus numbers.
---
 arch/arm/boot/dts/am33xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 7d7ca05..e58fab8 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -36,6 +36,8 @@
 		phy1 = &usb1_phy;
 		ethernet0 = &cpsw_emac0;
 		ethernet1 = &cpsw_emac1;
+		spi0 = &spi0;
+		spi1 = &spi1;
 	};
 
 	cpus {
-- 
1.9.1
