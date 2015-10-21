From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:10:06 +0100
Subject: [PATCH 09/19] ARM: dts: am335x: replace gpio-key,
 wakeup with wakeup-source property
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1445422216-29375-10-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
check for/support the legacy "gpio-key,wakeup" boolean property to
enable gpio buttons as wakeup source, "wakeup-source" is the new
standard binding.

This patch replaces the legacy "gpio-key,wakeup" with the unified
"wakeup-source" property in order to avoid any futher copy-paste
duplication.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/am335x-evm.dts    | 4 ++--
 arch/arm/boot/dts/am335x-evmsk.dts  | 2 +-
 arch/arm/boot/dts/am335x-pepper.dts | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 1942a5c8132d..a6e398a213ec 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -83,14 +83,14 @@
 			label = "volume-up";
 			linux,code = <115>;
 			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		switch at 10 {
 			label = "volume-down";
 			linux,code = <114>;
 			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 315bb02c9920..6b57baaa2bb0 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -123,7 +123,7 @@
 			label = "button2";
 			linux,code = <0x102>;
 			gpios = <&gpio0 30 GPIO_ACTIVE_HIGH>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		switch at 4 {
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 7106114c7464..5107dbb07a7d 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -627,21 +627,21 @@
 		label = "home";
 		linux,code = <KEY_HOME>;
 		gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
-		gpio-key,wakeup;
+		wakeup-source;
 	};
 
 	button at 1 {
 		label = "menu";
 		linux,code = <KEY_MENU>;
 		gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
-		gpio-key,wakeup;
+		wakeup-source;
 	};
 
 	buttons at 2 {
 		label = "power";
 		linux,code = <KEY_POWER>;
 		gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
-		gpio-key,wakeup;
+		wakeup-source;
 	};
 };
 
-- 
1.9.1
