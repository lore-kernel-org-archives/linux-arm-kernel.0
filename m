From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri,  4 Oct 2013 09:24:15 +0200
Subject: [PATCH v5 4/4] ARM: at91/dt: add watchdog properties to kizbox board
In-Reply-To: <1380871455-7324-1-git-send-email-b.brezillon@overkiz.com>
References: <1380871455-7324-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1380871455-7324-5-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add watchdog specific config for kizbox board.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/kizbox.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/kizbox.dts
index 02df191..928f6ee 100644
--- a/arch/arm/boot/dts/kizbox.dts
+++ b/arch/arm/boot/dts/kizbox.dts
@@ -53,6 +53,12 @@
 				status = "okay";
 			};
 
+			watchdog at fffffd40 {
+				timeout-sec = <15>;
+				atmel,max-heartbeat-sec = <16>;
+				atmel,min-heartbeat-sec = <0>;
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.9.5
