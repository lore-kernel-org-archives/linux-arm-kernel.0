From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 20 Mar 2014 00:15:45 +0200
Subject: [PATCH 2/2] ARM: dts: keystone: disable subpage write for davinci
 nand device
In-Reply-To: <1395267345-27795-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1395267345-27795-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1395267345-27795-3-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the property davinci-no-subpage-write to disable sub page write in the
nand driver.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/boot/dts/k2hk-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index 1a1335b..624520f 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -118,6 +118,7 @@
 			nand-ecc-mode = "hw";
 			ti,davinci-ecc-bits = <4>;
 			nand-on-flash-bbt;
+			ti,davinci-no-subpage-write;
 
 			partition at 0 {
 				label = "u-boot";
-- 
1.8.3.2
