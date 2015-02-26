From: george.mccollister@gmail.com (George McCollister)
Date: Thu, 26 Feb 2015 10:48:14 -0600
Subject: [PATCH] ARM: dts: am335x-lxm: Use rmii-clock-ext
Message-ID: <1424969294-5993-1-git-send-email-george.mccollister@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use external clock for RMII since the internal clock doesn't meet the
jitter requirements.

Signed-off-by: George McCollister <george.mccollister@gmail.com>
---
 arch/arm/boot/dts/am335x-lxm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index 7266a00..5c5667a 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -328,6 +328,10 @@
 	dual_emac_res_vlan = <3>;
 };
 
+&phy_sel {
+	rmii-clock-ext;
+};
+
 &mac {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&cpsw_default>;
-- 
2.2.2
