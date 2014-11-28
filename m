From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 28 Nov 2014 19:06:02 +0100
Subject: [PATCH v3 3/3] ARM: at91: sama5d4: Add SFR
In-Reply-To: <1417197962-19441-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1417197962-19441-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1417197962-19441-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sama5d4 has Special Function Registers that allow to manage DDR, OHCI, EBI
and AIC interrupt redirection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Changes in v3:
 - corrected a typo in the commit message

Changes in v2:
 - corrected reg address

 arch/arm/boot/dts/sama5d4.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index e0157b0f075c..9e281e22d591 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -826,6 +826,11 @@
 				status = "disabled";
 			};
 
+			sfr: sfr at f8028000 {
+				compatible = "atmel,sama5d4-sfr", "syscon";
+				reg = <0xf8028000 0x4000>;
+			};
+
 			mmc1: mmc at fc000000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfc000000 0x600>;
-- 
2.1.0
