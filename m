From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:10:13 +0100
Subject: [PATCH 16/19] ARM: dts: s5pv210: replace legacy *,
 wakeup property with wakeup-source
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1445422216-29375-17-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard and other driver will continue to support the legacy
"gpio-key,wakeup", "linux,input-wakeup" boolean property to enable the
wakeup source, "wakeup-source" is the new standard binding.

This patch replaces all the legacy wakeup properties with the unified
"wakeup-source" property in order to avoid any futher copy-paste
duplication.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/s5pv210-aquila.dts   | 4 ++--
 arch/arm/boot/dts/s5pv210-goni.dts     | 4 ++--
 arch/arm/boot/dts/s5pv210-smdkv210.dts | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index f00cea7aca2f..72f162e7040b 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -257,7 +257,7 @@
 			linux,code = <KEY_POWER>;
 			label = "power";
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
@@ -268,7 +268,7 @@
 
 &keypad {
 	linux,input-no-autorepeat;
-	linux,input-wakeup;
+	wakeup-source;
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <3>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index a3d4643b202e..f4d0a023c31c 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -239,7 +239,7 @@
 			linux,code = <KEY_POWER>;
 			label = "power";
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
@@ -250,7 +250,7 @@
 
 &keypad {
 	linux,input-no-autorepeat;
-	linux,input-wakeup;
+	wakeup-source;
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <3>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/s5pv210-smdkv210.dts
index da7d210df670..54fcc3fc82e2 100644
--- a/arch/arm/boot/dts/s5pv210-smdkv210.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkv210.dts
@@ -59,7 +59,7 @@
 
 &keypad {
 	linux,input-no-autorepeat;
-	linux,input-wakeup;
+	wakeup-source;
 	samsung,keypad-num-rows = <8>;
 	samsung,keypad-num-columns = <8>;
 	pinctrl-names = "default";
-- 
1.9.1
