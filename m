From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue,  1 Dec 2015 20:03:04 +0200
Subject: [PATCH V2 02/19] ARM: dts: am57xx: cl-som-am57x: dts: add RTC support
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448993001-19495-3-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EM3027 RTC chip support (over I2C4 bus).

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
  v2:

   * No fuctional changes.
   * Refactor patch with respect to the previous changes in I2C4 node structure.
   * Reformat subject

 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 087d62e..58156a9 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -242,6 +242,11 @@
 			#gpio-cells = <2>;
 		};
 	};
+
+	rtc0: rtc at 56 {
+		compatible = "emmicro,em3027";
+		reg = <0x56>;
+	};
 };
 
 &cpu0 {
-- 
1.9.1
