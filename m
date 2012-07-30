From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 30 Jul 2012 18:42:19 +0530
Subject: [PATCH 1/2] arm/dts: Mark vcxio, v2v1 and v1v8 regulators as always on
In-Reply-To: <1343653940-16614-1-git-send-email-rnayak@ti.com>
References: <1343653940-16614-1-git-send-email-rnayak@ti.com>
Message-ID: <1343653940-16614-2-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vcxio, v2v1 and v1v8 are expected to be always on, update the dtsi
for twl6030 to reflect this.

commit '86f5fc' regulator: core: Mark all DT based boards as having
full constraints) caused these to be disabled at late boot causing
OMAP4 boards (using twl6030) to lockup.

Reported-by: Kishon Vijay Abraham I <kishon@ti.com>
Reported-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Rajendra nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/twl6030.dtsi |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 3b2f351..d351b27 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -66,6 +66,7 @@
 
 	vcxio: regulator at 8 {
 		compatible = "ti,twl6030-vcxio";
+		regulator-always-on;
 	};
 
 	vusb: regulator at 9 {
@@ -74,10 +75,12 @@
 
 	v1v8: regulator at 10 {
 		compatible = "ti,twl6030-v1v8";
+		regulator-always-on;
 	};
 
 	v2v1: regulator at 11 {
 		compatible = "ti,twl6030-v2v1";
+		regulator-always-on;
 	};
 
 	clk32kg: regulator at 12 {
-- 
1.7.1
