From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 30 Jan 2017 20:44:39 +0200
Subject: [PATCH] ARM: bcm2835: dt: add index to the ethernet alias
Message-ID: <5942321c5d0bfea54eac64ace2b217e8e0b6220d.1485801879.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An alias name should have an index number even when it is the only of its type.
This allows U-Boot to add the local-mac-address property. Otherwise U-Boot
skips the alias.

Cc: Lubomir Rintel <lkundrak@v3.sk>
Fixes: 6a93792774 ("ARM: bcm2835: dt: Add the ethernet to the device trees")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi | 2 +-
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi b/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
index 12c981e51134..9a0599f711ff 100644
--- a/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
+++ b/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
@@ -1,6 +1,6 @@
 / {
 	aliases {
-		ethernet = &ethernet;
+		ethernet0 = &ethernet;
 	};
 };
 
diff --git a/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi b/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
index 3f0a56ebcf1f..dc7ae776db5f 100644
--- a/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
+++ b/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
@@ -1,6 +1,6 @@
 / {
 	aliases {
-		ethernet = &ethernet;
+		ethernet0 = &ethernet;
 	};
 };
 
-- 
2.11.0
