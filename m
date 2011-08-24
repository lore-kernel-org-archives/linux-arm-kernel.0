From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 24 Aug 2011 15:09:15 +0200
Subject: [RFC PATCH 09/10] arm/dts: OMAP4: Add gpio nodes
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314191356-10963-10-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 6 GPIOs controller nodes.
Since the GPIO driver is still under cleanup, a couple of temp
hacks are needed. They will be removed as soon as the driver will
be cleaned.

Remove gpio static device initialisation if CONFIG_OF is defined.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Charulatha V <charu@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   69 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpio.c   |    2 +
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 231d7b4..f672927 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -110,5 +110,74 @@
 			compatible = "ti,omap-spinlock";
 			hwmods = "spinlock";
 		};
+
+		gpio1: gpio at 1 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio1";
+			/* id should not be needed with a global GPIO parent */
+			id = <1>;
+			bank_width = <32>;
+			debounce;
+			/* XXX: big hack until the bank_count is removed */
+			bank_count = <6>;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio2: gpio at 2 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio2";
+			id = <2>;
+			bank_width = <32>;
+			debounce;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio3: gpio at 3 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio3";
+			id = <3>;
+			bank_width = <32>;
+			debounce;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio4: gpio at 4 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio4";
+			id = <4>;
+			bank_width = <32>;
+			debounce;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio5: gpio at 5 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio5";
+			id = <5>;
+			bank_width = <32>;
+			debounce;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio6: gpio at 6 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio6";
+			id = <6>;
+			bank_width = <32>;
+			debounce;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
 	};
 };
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 8cbfbc2..c51e952 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -16,6 +16,7 @@
  * GNU General Public License for more details.
  */
 
+#ifndef CONFIG_OF
 #include <linux/gpio.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -126,3 +127,4 @@ static int __init omap2_gpio_init(void)
 						NULL);
 }
 postcore_initcall(omap2_gpio_init);
+#endif
-- 
1.7.0.4
