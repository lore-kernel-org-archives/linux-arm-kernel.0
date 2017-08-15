From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 15 Aug 2017 10:26:02 -0700
Subject: [PATCH 5/6] ARM: dts: cygnus: add serial0 alias for uart3 on
 bcm91130_entphn
In-Reply-To: <1502817964-8221-1-git-send-email-scott.branden@broadcom.com>
References: <1502817964-8221-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1502817964-8221-6-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use serial0 alias to select stdout-path on Cygnus bcm911360_entphon
board.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm911360_entphn.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
index 000f5f1..53f990d 100644
--- a/arch/arm/boot/dts/bcm911360_entphn.dts
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -39,9 +39,12 @@
 	model = "Cygnus Enterprise Phone (BCM911360_ENTPHN)";
 	compatible = "brcm,bcm11360", "brcm,cygnus";
 
+	aliases {
+		serial0 = &uart3;
+	};
+
 	chosen {
-		stdout-path = &uart3;
-		bootargs = "console=ttyS0,115200";
+		stdout-path = "serial0:115200n8";
 	};
 
 	gpio_keys {
-- 
2.5.0
