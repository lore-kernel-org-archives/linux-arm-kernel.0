From: j-keerthy@ti.com (Keerthy)
Date: Thu, 9 Mar 2017 13:35:58 +0530
Subject: [PATCH v2 4/8] ARM: OMAP443x: Thermal: Add slope and offset values
In-Reply-To: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1489046762-11288-5-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the slope and offset values for calculating the
hot spot temperature of a particular thermal zone is part
of driver data. Pass them here instead and obtain the values
while of node parsing.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index fc6a861..03c8ad9 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -71,4 +71,8 @@
 
 };
 
+&cpu_thermal {
+	coefficients = <0 20000>;
+};
+
 /include/ "omap443x-clocks.dtsi"
-- 
1.9.1
