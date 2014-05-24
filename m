From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 24 May 2014 11:17:10 -0300
Subject: [PATCH 2/2] ARM: dts: Specify the NAND ECC scheme explicitly on
 Armada 385 DB board
In-Reply-To: <1400941030-2123-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1400941030-2123-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1400941030-2123-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The factory bootloader on A385-DB boards expect the ECC strength to be
4 bits over 512 bytes. Hence, we need to specify this in the devicetree,
to prevent the kernel from assuming any different ECC scheme.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index 8b004fe..0d4327b 100644
--- a/arch/arm/boot/dts/armada-385-db.dts
+++ b/arch/arm/boot/dts/armada-385-db.dts
@@ -98,6 +98,8 @@
 				marvell,nand-keep-config;
 				marvell,nand-enable-arbiter;
 				nand-on-flash-bbt;
+				nand-ecc-strength = <4>;
+				nand-ecc-step-size = <512>;
 
 				partition at 0 {
 					label = "U-Boot";
-- 
1.9.1
