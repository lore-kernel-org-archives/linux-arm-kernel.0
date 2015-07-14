From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 14 Jul 2015 14:45:27 -0500
Subject: [PATCH 4/4] ARM: dts: keystone: Add ti,keystone-spi for SPI
In-Reply-To: <1436903127-6777-1-git-send-email-fcooper@ti.com>
References: <1436903127-6777-1-git-send-email-fcooper@ti.com>
Message-ID: <1436903127-6777-5-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ti,keystone-spi to the compatible field for the SPI node. This new
entry insures that the proper prescaler limit is used for keystone devices

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index c06542b..ea2e1cd 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -136,7 +136,7 @@
 		};
 
 		spi0: spi at 21000400 {
-			compatible = "ti,dm6441-spi";
+			compatible = "ti,keystone-spi", "ti,dm6441-spi";
 			reg = <0x21000400 0x200>;
 			num-cs = <4>;
 			ti,davinci-spi-intr-line = <0>;
@@ -147,7 +147,7 @@
 		};
 
 		spi1: spi at 21000600 {
-			compatible = "ti,dm6441-spi";
+			compatible = "ti,keystone-spi", "ti,dm6441-spi";
 			reg = <0x21000600 0x200>;
 			num-cs = <4>;
 			ti,davinci-spi-intr-line = <0>;
@@ -158,7 +158,7 @@
 		};
 
 		spi2: spi at 21000800 {
-			compatible = "ti,dm6441-spi";
+			compatible = "ti,keystone-spi", "ti,dm6441-spi";
 			reg = <0x21000800 0x200>;
 			num-cs = <4>;
 			ti,davinci-spi-intr-line = <0>;
-- 
1.9.1
