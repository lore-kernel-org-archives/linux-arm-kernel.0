From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Nov 2016 01:09:50 +0100
Subject: [PATCH 04/14] ARM: dts: armada-375: Fixup bootrom DT warning
In-Reply-To: <20161110001000.10619-1-gregory.clement@free-electrons.com>
References: <20161110001000.10619-1-gregory.clement@free-electrons.com>
Message-ID: <20161110001000.10619-5-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bootrom has a reg property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 97b663d83fb6..e4150c34f128 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -110,7 +110,7 @@
 		pcie-mem-aperture = <0xe0000000 0x8000000>;
 		pcie-io-aperture  = <0xe8000000 0x100000>;
 
-		bootrom {
+		bootrom at 0 {
 			compatible = "marvell,bootrom";
 			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
 		};
-- 
2.10.1
