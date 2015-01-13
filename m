From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 13 Jan 2015 11:13:34 +0800
Subject: [PATCH] ARM: dts: hip04: move bootwrapper to SRAM
Message-ID: <54B48D5E.6050902@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is 8MB SRAM in hip04.
Moving the bootwrapper into SRAM could avoid to worry about poking
holes into DRAM memory or allocation algorithms either.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm/boot/dts/hip04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 2388145..f0dfac7 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -22,7 +22,7 @@
 
 	bootwrapper {
 	compatible = "hisilicon,hip04-bootwrapper";
-	boot-method = <0x10c00000 0x10000>, <0xe0000100 0x1000>;
+	boot-method = <0xe00f0000 0x10000>, <0xe0000100 0x1000>;
 	};
 
 	cpus {
-- 
1.8.1.2
