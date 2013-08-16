From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Fri, 16 Aug 2013 17:51:54 +0530
Subject: [PATCH v4 2/2] ARM: dts: AM33XX: update rtc node compatibility
In-Reply-To: <1376655714-28947-1-git-send-email-gururaja.hebbar@ti.com>
References: <1376655714-28947-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1376655714-28947-3-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hebbar Gururaja <gururaja.hebbar@ti.com>

Since AM33xx RTC IP has RTC_IRQWAKEEN to support Alarm Wake-up, update
the rtc compatible property to enable handling of this feature inside
rtc-omap driver.

Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
CC: mark.rutland at arm.com
---
Changes in V4:
	- No change.

Changes in V3:
	- Instead of replacing the old matching string, add new
	  matching compatible as 1st and maintain old compatible string
	  for backwards compatibility 

Changes in V2:
	- Add new compatible to existing one so that when driver
	  supports enhanced features of hardware, they are available
	  to the user else the basic functionality still works
:100644 100644 0aaf8ce... daeafa0... M	arch/arm/boot/dts/am33xx.dtsi
 arch/arm/boot/dts/am33xx.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0aaf8ce..daeafa0 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -317,7 +317,7 @@
 		};
 
 		rtc at 44e3e000 {
-			compatible = "ti,da830-rtc";
+			compatible = "ti,am3352-rtc", "ti,da830-rtc";
 			reg = <0x44e3e000 0x1000>;
 			interrupts = <75
 				      76>;
-- 
1.7.0.4
