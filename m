From: nm@ti.com (Nishanth Menon)
Date: Wed, 17 Jul 2013 11:45:31 -0500
Subject: [PATCH 2/9] ARM: dts: omap5-uevm: update SMPS9 settings
In-Reply-To: <1374079538-19548-1-git-send-email-nm@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
Message-ID: <1374079538-19548-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit e00c27ef3b4c23e39d0a77b7c8e5be44c28001c7
(ARM: dts: OMAP5: Add Palmas MFD node and regulator nodes)
introduced regulator entries for OMAP5uEVM.

However, The regulator information is based on an older temporary
pre-production board variant and does not reflect production board
750-2628-XXX boards.

SMPS9 supplies TWL6040 over VDDA_2v1_AUD. This regulator needs to be
enabled only when audio is active. Since it does not come active by
default, it does not require "always-on" or "boot-on".

Reported-by: Marc J?ttner <m-juettner@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index b430b8f..6709f1e 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -331,8 +331,6 @@
 					regulator-name = "smps9";
 					regulator-min-microvolt = <2100000>;
 					regulator-max-microvolt = <2100000>;
-					regulator-always-on;
-					regulator-boot-on;
 					ti,smps-range = <0x80>;
 				};
 
-- 
1.7.9.5
