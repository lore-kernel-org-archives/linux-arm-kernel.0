From: j-keerthy@ti.com (Keerthy)
Date: Thu, 9 Mar 2017 13:35:59 +0530
Subject: [PATCH v2 5/8] ARM: OMAP4460: Thermal: Add slope and offset values
In-Reply-To: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1489046762-11288-6-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the slope and offset values for calculating the
hot spot temperature of a particular thermal zone is part
of driver data. Pass them here instead and obtain the values
while of node parsing.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/omap4460.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index ef66e12..c43f2a2 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -90,4 +90,8 @@
 
 };
 
+&cpu_thermal {
+	coefficients = <348 (-9301)>;
+};
+
 /include/ "omap446x-clocks.dtsi"
-- 
1.9.1
