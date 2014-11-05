From: tony@atomide.com (Tony Lindgren)
Date: Wed,  5 Nov 2014 10:35:47 -0800
Subject: [PATCH 2/5] ARM: dts: Fix NAND last partition size on LDP
In-Reply-To: <1415212550-24692-1-git-send-email-tony@atomide.com>
References: <1415212550-24692-1-git-send-email-tony@atomide.com>
Message-ID: <1415212550-24692-3-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warning during the boot:

mtd: partition "Filesystem" extends beyond the end of device
"omap2-nand.0" -- size truncated to 0x6000000

Looks like I got the last partition size wrong while setting
up the .dts file. Note that this does not affect the partition
as the size has been getting truncated to the right size.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-ldp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 72dca0b..f7a45de 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -141,7 +141,7 @@
 		};
 		partition at 2000000 {
 			label = "Filesystem";
-			reg = <0x2000000 0xe000000>;
+			reg = <0x2000000 0x6000000>;
 		};
 	};
 
-- 
2.1.1
