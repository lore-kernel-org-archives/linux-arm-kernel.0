From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 29 Mar 2015 20:09:35 +0200
Subject: [PATCH 2/2] ARM: dts: sun5i: Add broken-hpi property for Utoo-P66 eMMC
In-Reply-To: <1427652575-12642-1-git-send-email-hdegoede@redhat.com>
References: <1427652575-12642-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1427652575-12642-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC on the A13 based Utoo-P66 tablet does not properly support hpi,
and trying to enable it results in the eMMC not working, so add a child-node
describing the eMMC, and set the broken-hpi property on it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index 6c9f5f3..5b572fa 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -150,6 +150,12 @@
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
+
+	mmmcard: mmccard at 0 {
+		reg = <0>;
+		compatible = "mmc-card";
+		broken-hpi;
+	};
 };
 
 &pio {
-- 
2.3.4
