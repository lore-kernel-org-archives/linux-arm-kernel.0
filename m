From: jvial@adeneo-embedded.com (Jeremy Vial)
Date: Thu, 31 Jul 2014 15:10:33 +0200
Subject: [PATCH 1/2] ARM: OMAP3: Fix choice of omap3_restore_es function in
 OMAP34XX rev3.1.2 case.
In-Reply-To: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
References: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
Message-ID: <1406812234-23163-2-git-send-email-jvial@adeneo-embedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the comment ?restore_es3: applies to 34xx >= ES3.0" in
"arch/arm/mach-omap2/sleep34xx.S?, omap3_restore_es3 should be used
if the revision of an OMAP34xx is ES3.1.2.

Signed-off-by: Jeremy Vial <jvial@adeneo-embedded.com>
---
 arch/arm/mach-omap2/control.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 751f354..acadac0 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -314,7 +314,8 @@ void omap3_save_scratchpad_contents(void)
 		scratchpad_contents.public_restore_ptr =
 			virt_to_phys(omap3_restore_3630);
 	else if (omap_rev() != OMAP3430_REV_ES3_0 &&
-					omap_rev() != OMAP3430_REV_ES3_1)
+					omap_rev() != OMAP3430_REV_ES3_1 &&
+					omap_rev() != OMAP3430_REV_ES3_1_2)
 		scratchpad_contents.public_restore_ptr =
 			virt_to_phys(omap3_restore);
 	else
-- 
1.7.9.5
