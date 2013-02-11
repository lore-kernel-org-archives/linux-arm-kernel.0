From: rogerq@ti.com (Roger Quadros)
Date: Mon, 11 Feb 2013 17:44:24 +0200
Subject: [PATCH 2/2] ARM: dts: omap4-panda: Add clock alias for USB PHY
In-Reply-To: <1360597464-8491-1-git-send-email-rogerq@ti.com>
References: <1360597464-8491-1-git-send-email-rogerq@ti.com>
Message-ID: <1360597464-8491-2-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Panda, the USB Host PHY is clocked by FREF3_CLK (auxclk3_ck) pin
of the OMAP. Provide this information in the device tree.

CC: Russell King <linux@arm.linux.org.uk>
CC: Rajendra Nayak <rnayak@ti.com>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index d6e59c7..a7d66cc 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -86,6 +86,13 @@
 		reset-supply = <&hsusb1_reset>;
 		vcc-supply = <&hsusb1_power>;
 	};
+
+	/* hsusb1_phy is clocked by FREF_CLK3 i.e. auxclk3 */
+	clock_alias {
+		clock-name = "auxclk3_ck";
+		clock-alias = "main_clk";
+		device = <&hsusb1_phy>;
+	};
 };
 
 &omap4_pmx_core {
-- 
1.7.4.1
