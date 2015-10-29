From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 29 Oct 2015 13:55:47 +0800
Subject: [RFC PATCH 2/2] ARM: at91/dt: sama5d2_xplained: add pmc_fast_restart
 node
In-Reply-To: <1446098147-32487-1-git-send-email-wenyou.yang@atmel.com>
References: <1446098147-32487-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1446098147-32487-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pmc_fast_restart node as a pmc child node.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index e8d63afd..711d82f 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -91,6 +91,14 @@
 		};
 
 		apb {
+			pmc: pmc at f0014000 {
+				pmc_fast_restart {
+					compatible = "atmel,sama5d2-pmc-fast-startup";
+					atmel,fast-startup-wake-up;
+					atmel,fast-startup-rtc-alarm;
+				};
+			};
+
 			spi0: spi at f8000000 {
 				status = "okay";
 
-- 
1.7.9.5
