From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  2 Dec 2011 11:53:00 +0200
Subject: [PATCH 5/5] ARM: OMAP4: DTS: Support for dmic,
 and McPDM in device tree
In-Reply-To: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1322819580-7424-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support for dmic, and McPDM on OMAP4 platforms.
Panda board does not have DMIC lines accessable, so
disable the dmic on panda.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |    4 ++++
 arch/arm/boot/dts/omap4.dtsi      |    9 +++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index c702657..b73b641 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -27,3 +27,7 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 };
+
+&dmic_dai {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4c61c82..00cfb73 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -99,5 +99,14 @@
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0100>;
 		};
+
+		dmic_dai: dmic at 4012e000 {
+			compatible = "ti,omap4-dmic";
+			ti,hwmods = "dmic";
+		};
+		mcpdm_dai: mcpdm at 40132000 {
+			compatible = "ti,omap4-mcpdm";
+			ti,hwmods = "mcpdm";
+		};
 	};
 };
-- 
1.7.8.rc4
