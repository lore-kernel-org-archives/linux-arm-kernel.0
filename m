From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Fri, 25 May 2012 11:26:01 +0300
Subject: [RFC PATCH 11/11] ARM: DT: Add support to system control module for
 OMAP4
In-Reply-To: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1337934361-1606-12-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add device tree entries on OMAP4 based boards
for System Control Module (SCM).

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..d2cb392 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,18 @@
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
+
+		ctrl_module_core: ctrl_module_core at 4a002000 {
+			compatible = "ti,omap4-control";
+			ti,hwmods = "ctrl_module_core";
+			bandgap {
+				compatible = "ti,omap4460-bandgap";
+				interrupts = <0 126 4>; /* talert */
+				ti,tshut-gpio = <86>; /* tshut */
+			};
+			usb {
+				compatible = "ti,omap4-usb-phy";
+			};
+		};
 	};
 };
-- 
1.7.7.1.488.ge8e1c
