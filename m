From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Apr 2012 11:02:36 +0100
Subject: [PATCH 15.1/15] ARM: ux500: Configure the PRCMU Timer for db8500
 based devices in DT
In-Reply-To: <CACRpkdaU+1XqXMRfv+3dTLCnw7J=dgFW394TNyAYuRUwupnD8w@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-16-git-send-email-lee.jones@linaro.org>
 <CACRpkdaU+1XqXMRfv+3dTLCnw7J=dgFW394TNyAYuRUwupnD8w@mail.gmail.com>
Message-ID: <4F967A3C.1040101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 24 Apr 2012 10:00:15 +0100
Subject: [PATCH 15.1/15] ARM: ux500: Configure the PRCMU Timer for db8500 based devices in DT

This patch adds the information required for successful
registration of the PRCMU timer 4 (clocksource) driver to the
db8500 Device Tree include file.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index f633210..9a62f86 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -189,7 +189,13 @@
 			reg = <0x80157000 0x1000>;
 			interrupts = <46 47>;
 			#address-cells = <1>;
-			#size-cells = <0>;
+			#size-cells = <1>;
+			ranges;
+
+				prcmu-timer-4 at 80157450 {
+				compatible = "stericsson,db8500-prcmu-timer-4";
+				reg = <0x80157450 0xC>;
+			};
 
 			ab8500 at 5 {
 				compatible = "stericsson,ab8500";
-- 
1.7.9.1
