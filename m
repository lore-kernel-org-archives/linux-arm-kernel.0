From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 8 Mar 2016 09:42:01 +0800
Subject: [PATCH v4 4/5] Documentation: atmel-pmc: add DT bindings for fast
 startup
In-Reply-To: <1457401322-29120-1-git-send-email-wenyou.yang@atmel.com>
References: <1457401322-29120-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1457401322-29120-5-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings to configurate the PMC_FSMR and PMC_FSPR registers
to trigger a fast restart signal to PMC.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Rob Herring <robh+dt@kernel.org>
---

Changes in v4:
 - add Acked-by tag.

Changes in v3:
 - update the property description.

Changes in v2:
 - change the property name and property description.

 .../devicetree/bindings/arm/atmel-pmc.txt          |   63 ++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-pmc.txt b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
index 795cc78..0d2481c 100644
--- a/Documentation/devicetree/bindings/arm/atmel-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
@@ -12,3 +12,66 @@ Examples:
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
+- atmel,wkup-trigger: boolean, WKUP input can trigger a fast restart signal.
+- atmel,secumod-trigger: boolean, SECUMOD can trigger a fast restart signal.
+- atmel,piobu0-trigger: boolean, PIOBU0 input can trigger a fast restart signal.
+- atmel,piobu1-trigger: boolean, PIOBU1 input can trigger a fast restart signal.
+- atmel,piobu2-trigger: boolean, PIOBU2 input can trigger a fast restart signal.
+- atmel,piobu3-trigger: boolean, PIOBU3 input can trigger a fast restart signal.
+- atmel,piobu4-trigger: boolean, PIOBU4 input can trigger a fast restart signal.
+- atmel,piobu5-trigger: boolean, PIOBU5 input can trigger a fast restart signal.
+- atmel,piobu6-trigger: boolean, PIOBU6 input can trigger a fast restart signal.
+- atmel,piobu7-trigger: boolean, PIOBU7 input can trigger a fast restart signal.
+- atmel,gmac-wol-trigger: boolean, GMAC_WOL can trigger a fast restart signal.
+- atmel,rtc-alarm-trigger: boolean, RTC alarm can trigger a fast restart signal.
+- atmel,usb-resume-trigger: boolean, USB resume can trigger a fast restart
+  signal.
+- atmel,sdmmc-cd-trigger: boolean, SDMMC card detect can trigger a fast
+  restart signal.
+- atmel,rxlp-match-trigger: boolean, Matching condition on RXLP can trigger
+  a fast restart signal.
+- atmel,acc-comparison-trigger: boolean, ACC comparison can trigger a fast
+  restart signal.
+
+- atmel,wkup-trigger-level: int, defines the active polarity of the wake-up
+  input. Supported values are: 1 or 0.
+- atmel,piobu0-trigger-level: int, defines the active polarity of
+  the corresponding PIOBU0 input. Supported values are: 1 or 0.
+- atmel,piobu1-trigger-level: int, defines the active polarity of
+  the corresponding PIOBU1 input. Supported values are: 1 or 0.
+- atmel,piobu2-trigger-level: int, defines the active polarity of
+  the corresponding PIOBU2 input. Supported values are: 1 or 0".
+- atmel,piobu3-trigger-level: int, defines the active polarity of
+  the corresponding PIOBU3 input. Supported values are: 1 or 0.
+- atmel,piobu4-trigger-level: int, defines the active polarity of
+  the corresponding PIOBU4 input. Supported values are: 1 or 0.
+- atmel,piobu5-trigger-level: int, defines the active polarity of
+  the corresponding PIOBU5 input. Supported values are: 1 or 0.
+- atmel,piobu6-trigger-level: int, defines the active polarity of
+  the corresponding PIOBU6 input. Supported values are: 1 or 0.
+- atmel,piobu7-trigger-level: int, defines the active polarity of
+  the corresponding PIOBU7 input. Supported values are: 1 or 0.
+
+Example:
+
+	pmc: pmc at f0014000 {
+		compatible = "atmel,sama5d2-pmc";
+		reg = <0xf0014000 0x160>;
+
+		pmc_fast_restart {
+			compatible = "atmel,sama5d2-pmc-fast-startup";
+			atmel,wkup-trigger;
+			atmel,rtc-alarm-trigger;
+			atmel,wkup-trigger-level = <0>;
+		};
+	};
-- 
1.7.9.5
