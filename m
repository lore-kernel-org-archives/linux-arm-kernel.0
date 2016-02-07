From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Sun,  7 Feb 2016 19:34:26 +0100
Subject: [PATCH 1/1] ARM: kirkwood-ds112.dts: use unique machine name
Message-ID: <1454870066-3353-1-git-send-email-xypron.glpk@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Downstream packages like Debian flash-kernel use
/proc/device-tree/model
to determine which dtb file to install.

Hence each dts in the Linux kernel should provide a unique model
identifier.

Commit 2d0a7addbd10 ("ARM: Kirkwood: Add support for many Synology NAS
devices") created the new files kirkwood-ds111.dts and kirkwood-ds112.dts
using the same model identifier.

This patch provides a unique model identifier for the
Synology DiskStation DS112.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/arm/boot/dts/kirkwood-ds112.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-ds112.dts b/arch/arm/boot/dts/kirkwood-ds112.dts
index bf4143c..b84af3d 100644
--- a/arch/arm/boot/dts/kirkwood-ds112.dts
+++ b/arch/arm/boot/dts/kirkwood-ds112.dts
@@ -14,7 +14,7 @@
 #include "kirkwood-synology.dtsi"
 
 / {
-	model = "Synology DS111";
+	model = "Synology DS112";
 	compatible = "synology,ds111", "marvell,kirkwood";
 
 	memory {
-- 
2.1.4
