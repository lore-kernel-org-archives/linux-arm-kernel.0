From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 28 Jun 2016 18:04:21 -0700
Subject: [PATCH] ARM: dts: NSP: Specify RAM amount for BCM958625HR board
Message-ID: <1467162261-14128-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 512MB of memory starting at physical offset 0x6000_0000.

Fixes: 65e9ac208c8e ("ARM: dts: NSP: Add new DT file for bcm958625hr")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm958625hr.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 585ec9de00eb..747f9ca9d03f 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -45,6 +45,10 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	memory {
+		reg = <0x60000000 0x20000000>;
+	};
 };
 
 &nand {
-- 
2.7.4
