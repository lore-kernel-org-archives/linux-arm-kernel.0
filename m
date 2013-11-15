From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 15 Nov 2013 15:20:25 +0100
Subject: [PATCH 2/2] ARM: kirkwood: mark guruplug sdio as non-removable
In-Reply-To: <1384525225-591-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1384525225-591-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1384525225-591-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Globalscale Guruplug has AW-GH381 WiFi/BT on sdio which is always
present and cannot be detected in any way. Therefore, mark the node
as non-removable instead of broken-cd. While at it, also put a note
about connected WiFi/BT chip above.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree at vger.kernel.org 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: linux-kernel at vger.kernel.org 
---
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
index 6548b9d..4ebe720 100644
--- a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
+++ b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
@@ -65,10 +65,10 @@
 			nr-ports = <1>;
 		};
 
+		/* AzureWave AW-GH381 WiFi/BT */
 		mvsdio at 90000 {
 			status = "okay";
-			/* No CD or WP GPIOs */
-			broken-cd;
+			non-removable;
 		};
 	};
 
-- 
1.7.2.5
