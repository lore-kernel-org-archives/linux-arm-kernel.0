From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  1 Apr 2015 17:26:24 +0200
Subject: [PATCH v2 2/2] ARM: dts: sun5i: Add broken-hpi property for Utoo-P66
 eMMC
In-Reply-To: <1427901984-26469-1-git-send-email-hdegoede@redhat.com>
References: <1427901984-26469-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1427901984-26469-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC on the A13 based Utoo-P66 tablet does not properly support hpi,
and trying to enable it results in the eMMC not working, so add a child-node
describing the eMMC, and set the broken-hpi property on it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Fix mmmcard typo
---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index bfbe08b..9108ecd 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -135,6 +135,12 @@
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
+
+	mmccard: mmccard at 0 {
+		reg = <0>;
+		compatible = "mmc-card";
+		broken-hpi;
+	};
 };
 
 &pio {
-- 
2.3.4
