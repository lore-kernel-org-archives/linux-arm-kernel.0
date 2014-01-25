From: marek@goldelico.com (Marek Belisko)
Date: Sat, 25 Jan 2014 22:29:02 +0100
Subject: [PATCH 8/9] ARM: dts: omap3-gta04: Add support for magnetometer.
In-Reply-To: <1390685343-11663-1-git-send-email-marek@goldelico.com>
References: <1390685343-11663-1-git-send-email-marek@goldelico.com>
Message-ID: <1390685343-11663-9-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: NeilBrown <neilb@suse.de>
---
 arch/arm/boot/dts/omap3-gta04.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 151ed3b..ea1b94d 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -100,6 +100,12 @@
 			regulator-max-microvolt = <3150000>;
 		};
 	};
+
+	/* compass aka magnetometer */
+	hmc5843 at 1e {
+		compatible = "honeywell,hmc5843";
+		reg = <0x1e>;
+	};
 };
 
 #include "twl4030.dtsi"
-- 
1.8.3.2
