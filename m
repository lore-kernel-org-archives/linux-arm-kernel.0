From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Fri, 25 May 2012 18:42:30 +0800
Subject: [PATCH 1/3] arm/dts: add wdt node for omap3 and omap4
In-Reply-To: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
Message-ID: <1337942552-28218-2-git-send-email-jgq516@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiao Jiang <jgq516@gmail.com>

Add wdt node to support dt.

Signed-off-by: Xiao Jiang <jgq516@gmail.com>
---
 arch/arm/boot/dts/omap3.dtsi |    5 +++++
 arch/arm/boot/dts/omap4.dtsi |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 99474fa..039df5c 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -215,5 +215,10 @@
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc3";
 		};
+
+		wdt: wdt at 48314000{
+			compatible = "ti,omap3-wdt";
+			ti,hwmods = "wd_timer2";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..d01403d 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,10 @@
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
+
+		wdt: wdt at 4a314000{
+			compatible = "ti,omap4-wdt";
+			ti,hwmods = "wd_timer2";
+		};
 	};
 };
-- 
1.7.3
