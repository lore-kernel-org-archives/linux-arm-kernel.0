From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 20 Mar 2014 22:20:13 +0200
Subject: [PATCH v2] ARM: dts: k2hk-evm: set ubifs partition size for 512M NAND
Message-ID: <1395346813-13439-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

The UBIFS partition size was incorrectly defined as for 128M NAND,
but on k2hk-evm installed NAND flash size is 512M.
Hence, correct it.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---

Just cut from series
v1:
[PATCH 1/3] ARM: dts: k2hk-evm: set ubifs partition size for 512M NAND
https://lkml.org/lkml/2014/3/20/462

 arch/arm/boot/dts/k2hk-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index 1a1335b..949ef7d 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -133,7 +133,7 @@
 
 			partition at 180000 {
 				label = "ubifs";
-				reg = <0x180000 0x7E80000>;
+				reg = <0x180000 0x1fe80000>;
 			};
 		};
 	};
-- 
1.8.3.2
