From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 11 Jun 2014 18:14:42 +0800
Subject: [PATCH v2 4/4] dts: atmel: at91sam9g20: switch ssc compatible string
In-Reply-To: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
References: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1402481682-9811-5-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the SSC integrate in at91sam9g20 support frame sync length
extension, so switch compatible string to support this feature.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v2:
  - New

 arch/arm/boot/dts/at91sam9g20.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index b8e7946..dcd39fe 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -22,6 +22,10 @@
 				compatible = "atmel,at91sam9g20-i2c";
 			};
 
+			ssc0: ssc at fffbc000 {
+				compatible = "atmel,at91sam9rl-ssc";
+			};
+
 			adc0: adc at fffe0000 {
 				atmel,adc-startup-time = <40>;
 			};
-- 
1.8.5.2
