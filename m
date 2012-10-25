From: nm@ti.com (Nishanth Menon)
Date: Thu, 25 Oct 2012 12:58:08 -0500
Subject: [PATCH] ARM: OMAP2+: PM: VP: minor pr_warn updates
Message-ID: <1351187888-22018-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change pr_warnings to pr_warn and ensure a newline
is present in all messages

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vp.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 85241b8..60d8515 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -138,7 +138,7 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 		udelay(1);
 	}
 	if (timeout >= VP_TRANXDONE_TIMEOUT) {
-		pr_warn("%s: vdd_%s TRANXDONE timeout exceeded. Voltage change aborted",
+		pr_warn("%s: vdd_%s TRANXDONE timeout exceeded. Voltage change aborted\n",
 			__func__, voltdm->name);
 		return -ETIMEDOUT;
 	}
@@ -197,7 +197,7 @@ void omap_vp_enable(struct voltagedomain *voltdm)
 	u32 vpconfig, volt;
 
 	if (!voltdm || IS_ERR(voltdm)) {
-		pr_warning("%s: VDD specified does not exist!\n", __func__);
+		pr_warn("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
 
@@ -214,7 +214,7 @@ void omap_vp_enable(struct voltagedomain *voltdm)
 
 	volt = voltdm_get_voltage(voltdm);
 	if (!volt) {
-		pr_warning("%s: unable to find current voltage for %s\n",
+		pr_warn("%s: unable to find current voltage for %s\n",
 			   __func__, voltdm->name);
 		return;
 	}
@@ -242,7 +242,7 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 	int timeout;
 
 	if (!voltdm || IS_ERR(voltdm)) {
-		pr_warning("%s: VDD specified does not exist!\n", __func__);
+		pr_warn("%s: VDD specified does not exist!\n", __func__);
 		return;
 	}
 
@@ -272,8 +272,7 @@ void omap_vp_disable(struct voltagedomain *voltdm)
 			  VP_IDLE_TIMEOUT, timeout);
 
 	if (timeout >= VP_IDLE_TIMEOUT)
-		pr_warning("%s: vdd_%s idle timedout\n",
-			__func__, voltdm->name);
+		pr_warn("%s: vdd_%s idle timedout\n", __func__, voltdm->name);
 
 	vp->enabled = false;
 
-- 
1.7.9.5
