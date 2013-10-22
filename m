From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 14:47:21 +0200
Subject: [PATCHv2 2/3] DTS: ARM: TWL4030: Add keypad node
In-Reply-To: <1382446042-27099-1-git-send-email-sre@debian.org>
References: <1382446042-27099-1-git-send-email-sre@debian.org>
Message-ID: <1382446042-27099-3-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add keypad node to twl4030, so that board DTS
files can just add the keymap.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/twl4030.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index ae6a17a..773c94c 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -97,4 +97,11 @@
 		compatible = "ti,twl4030-pwmled";
 		#pwm-cells = <2>;
 	};
+
+	twl_keypad: keypad {
+		compatible = "ti,twl4030-keypad";
+		interrupts = <1>;
+		keypad,num-rows = <8>;
+		keypad,num-columns = <8>;
+	};
 };
-- 
1.8.4.rc3
