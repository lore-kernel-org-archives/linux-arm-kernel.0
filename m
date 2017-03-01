From: j-keerthy@ti.com (Keerthy)
Date: Wed, 1 Mar 2017 15:59:47 +0530
Subject: [PATCH 4/7] ARM: OMAP4460: Thermal: Add slope and offset values
In-Reply-To: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
References: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1488364190-23488-5-git-send-email-j-keerthy@ti.com>
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
