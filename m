From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Tue, 21 Apr 2015 14:05:15 +0200
Subject: [PATCH v2 4/7] ARM: at91/dt: at91-kizbox: gpio-keys related changes
In-Reply-To: <1429617918-32086-1-git-send-email-g.portay@overkiz.com>
References: <1429617918-32086-1-git-send-email-g.portay@overkiz.com>
Message-ID: <1429617918-32086-5-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This:
 * fixes active level of GPIO (active high) and
 * renames buttons:
   - reset (PB_RST), and
   - mode to user (PB_USER).

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
---
 arch/arm/boot/dts/at91-kizbox.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index 72d5de80..73e4559 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -89,15 +89,15 @@
 		#size-cells = <0>;
 
 		reset {
-			label = "reset";
-			gpios = <&pioB 30 GPIO_ACTIVE_LOW>;
+			label = "PB_RST";
+			gpios = <&pioB 30 GPIO_ACTIVE_HIGH>;
 			linux,code = <0x100>;
 			gpio-key,wakeup;
 		};
 
-		mode {
-			label = "mode";
-			gpios = <&pioB 31 GPIO_ACTIVE_LOW>;
+		user {
+			label = "PB_USER";
+			gpios = <&pioB 31 GPIO_ACTIVE_HIGH>;
 			linux,code = <0x101>;
 			gpio-key,wakeup;
 		};
-- 
1.9.1
