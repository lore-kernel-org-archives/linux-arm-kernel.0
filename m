From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 8 Mar 2016 09:42:02 +0800
Subject: [PATCH v4 5/5] ARM: at91/dt: sama5d2_xplained: add fast_restart node
In-Reply-To: <1457401322-29120-1-git-send-email-wenyou.yang@atmel.com>
References: <1457401322-29120-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1457401322-29120-6-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add fast_restart node as a pmc's child node to support fast startup
signal configuration.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v4:
 - add fast_restart node to the DT file.

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 21c780f..45a78a7 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -110,6 +110,14 @@
 		};
 
 		apb {
+			pmc: pmc at f0014000 {
+				pmc_fast_restart {
+					compatible = "atmel,sama5d2-pmc-fast-startup";
+					atmel,wkup-trigger;
+					atmel,rtc-alarm-trigger;
+				};
+			};
+
 			spi0: spi at f8000000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0_default>;
-- 
1.7.9.5
