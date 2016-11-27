From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Nov 2016 20:37:24 +0100
Subject: [PATCH] ARM: dts: mvebu: Fix armada-385-turris-omnia stdout-path
In-Reply-To: <71af60f5-b657-cab4-32a8-00a604fc656e@suse.de>
References: <71af60f5-b657-cab4-32a8-00a604fc656e@suse.de>
Message-ID: <1480275444-4220-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify the baudrate.

Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")
Cc: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index f53cb8b73610..2eff012287d4 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -52,7 +52,7 @@
 	compatible = "cznic,turris-omnia", "marvell,armada385", "marvell,armada380";
 
 	chosen {
-		stdout-path = &uart0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.6.6
