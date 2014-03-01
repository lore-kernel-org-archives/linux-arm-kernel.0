From: marek@goldelico.com (Marek Belisko)
Date: Sat,  1 Mar 2014 14:58:49 +0100
Subject: [PATCH v2 2/7] ARM: dts: omap3-gta04: Add support for magnetometer
In-Reply-To: <1393682334-26805-1-git-send-email-marek@goldelico.com>
References: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Message-ID: <1393682334-26805-3-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neilb@suse.de>

Add magnetometer hmc5843 node.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index d3b253b..d9917b8 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -124,6 +124,12 @@
 			reg = <0x4>;
 		};
 	};
+
+	/* compass aka magnetometer */
+	hmc5843 at 1e {
+		compatible = "honeywell,hmc5843";
+		reg = <0x1e>;
+	};
 };
 
 &i2c3 {
-- 
1.8.3.2
