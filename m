From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Thu, 30 Apr 2015 09:33:34 +0200
Subject: [PATCH v3 3/7] ARM: at91/dt: at91-kizbox: user proper serial uart
In-Reply-To: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
References: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
Message-ID: <1430379218-13758-4-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USART3 is the only serial UART accessible.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91-kizbox.dts | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index 00c86c1..72d5de80 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -38,14 +38,6 @@
 
 	ahb {
 		apb {
-			usart0: serial at fffb0000 {
-				status = "okay";
-			};
-
-			usart1: serial at fffb4000 {
-				status = "okay";
-			};
-
 			macb0: ethernet at fffc4000 {
 				phy-mode = "mii";
 				pinctrl-0 = <&pinctrl_macb_rmii
@@ -53,6 +45,10 @@
 				status = "okay";
 			};
 
+			usart3: serial at fffd0000 {
+				status = "okay";
+			};
+
 			dbgu: serial@fffff200 {
 				status = "okay";
 			};
-- 
1.9.1
