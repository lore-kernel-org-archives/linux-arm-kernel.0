From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 28 Jan 2016 18:19:16 +0800
Subject: [PATCH 4/4] Documentation: atmel-at91: add DT bindings for fast
 startup
In-Reply-To: <1453976356-24391-1-git-send-email-wenyou.yang@atmel.com>
References: <1453976356-24391-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1453976356-24391-5-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings to configurate the PMC_FSMR and PMC_FSPR registers
to trigger a fast restart signal to PMC.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 .../devicetree/bindings/arm/atmel-pmc.txt          |   74 ++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-pmc.txt b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
index 795cc78..8d45ff9f 100644
--- a/Documentation/devicetree/bindings/arm/atmel-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
@@ -12,3 +12,77 @@ Examples:
 		compatible = "atmel,at91rm9200-pmc";
 		reg = <0xfffffc00 0x100>;
 	};
+
+PMC Fast Startup Signals
+
+The PMC Fast Start Signals are used as the wake up source to trigger the PMC
+to wake up the system from the ULP1 mode.
+
+required properties:
+- compatible: Should be "atmel,sama5d2-pmc-fast-startup".
+
+optional properties:
+- atmel,fast-startup-wake-up: boolean to enable the WKUP pin to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-secumod: boolean to enable the Security Mode to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-piobu0: boolean to enable the PIOBU0 Input to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-piobu1: boolean to enable the PIOBU1 Input to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-piobu2: boolean to enable the PIOBU2 Input to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-piobu3: boolean to enable the PIOBU3 Input to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-piobu4: boolean to enable the PIOBU4 Input to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-piobu5: boolean to enable the PIOBU5 Input to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-piobu6: boolean to enable the PIOBU6 Input to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-piobu7: boolean to enable the PIOBU7 Input to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-gmac-wol: boolean to enable the GMAC Wake-up On LAN
+  to trigger a fast restart signal to the PMC.
+- atmel,fast-startup-rtc-alarm: boolean to enable the RTC Alarm to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-usb-resume: boolean to enable the USB Resume to trigger
+  a fast restart signal to the PMC.
+- atmel,fast-startup-sdmmc-cd: boolean to enable the SDMMC Card Detect
+  to trigger a fast restart signal to the PMC.
+- atmel,fast-startup-rxlp-match: boolean to enable the Backuo UART Receive
+  Match Condition to trigger a fast restart signal to the PMC.
+- atmel,fast-startup-acc-comparison: boolean to enable the Analog Comparator
+  Controller (ACC) Comparison to to trigger a fast restart signal to the PMC.
+
+- atmel,fast-startup-wkup-pin-high: boolean to indicate if the WKUP Pin is
+  in the high level to trigger fast restart signal, otherwise low level.
+- atmel,fast-startup-piobu0-high: boolean to indicate if the PIOBU0 Pin is
+  in the high level to trigger fast restart signal, otherwise low level.
+- atmel,fast-startup-piobu1-high: boolean to indicate if the PIOBU1 Pin is
+  in the high level to trigger fast restart signal, otherwise low level.
+- atmel,fast-startup-piobu2-high: boolean to indicate if the PIOBU2 Pin is
+  in the high level to trigger fast restart signal, otherwise low level.
+- atmel,fast-startup-piobu3-high: boolean to indicate if the PIOBU3 Pin is
+  in the high level to trigger fast restart signal, otherwise low level.
+- atmel,fast-startup-piobu4-high: boolean to indicate if the PIOBU4 Pin is
+  in the high level to trigger fast restart signal, otherwise low level.
+- atmel,fast-startup-piobu5-high: boolean to indicate if the PIOBU5 Pin is
+  in the high level to trigger fast restart signal, otherwise low level.
+- atmel,fast-startup-piobu6-high: boolean to indicate if the PIOBU6 Pin is
+  in the high level to trigger fast restart signal, otherwise low level.
+- atmel,fast-startup-piobu7-high: boolean to indicate if the PIOBU7 Pin is
+  in the high level to trigger fast restart signal, otherwise low level.
+
+Example:
+
+	pmc: pmc at f0014000 {
+		compatible = "atmel,sama5d2-pmc";
+		reg = <0xf0014000 0x160>;
+
+		pmc_fast_restart {
+			compatible = "atmel,sama5d2-pmc-fast-startup";
+			atmel,fast-startup-wake-up;
+			atmel,fast-startup-rtc-alarm;
+		};
+	};
-- 
1.7.9.5
