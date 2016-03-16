From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 16 Mar 2016 14:58:09 +0800
Subject: [PATCH v5 5/5] ARM: at91/dt: sama5d2_xplained: add fast_restart node
In-Reply-To: <1458111489-23774-1-git-send-email-wenyou.yang@atmel.com>
References: <1458111489-23774-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1458111489-23774-6-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add fast_restart node as a pmc's child node to support fast startup
signal configuration.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v5:
 - due to the DT property expression change, update the fast restart
   node's property.

Changes in v4:
 - add fast_restart node to the DT file.

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 21c780f..31df6e8 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -110,6 +110,25 @@
 		};
 
 		apb {
+			pmc: pmc at f0014000 {
+				pmc_fast_restart {
+					compatible = "atmel,sama5d2-pmc-fast-startup";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					atmel,wakeup-rtc-timer;
+
+					wkpin: input at 0 {
+						reg = <0>;
+					};
+
+					gmac_wol: input at 10 {
+						reg = <10>;
+						atmel,wakeup-active-high;
+					};
+				};
+			};
+
 			spi0: spi at f8000000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0_default>;
-- 
1.7.9.5
