From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 18 Jun 2012 00:16:05 -0600
Subject: [PATCHv3 3/7] ARM: OMAP4+: hwmod: fix issue causing IPs not going
 back to Smart-Standby
In-Reply-To: <20120618061037.30632.28539.stgit@dusk>
References: <20120618061037.30632.28539.stgit@dusk>
Message-ID: <20120618061601.30632.66296.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Djamil Elaidi <d-elaidi@ti.com>

If an IP is configured in Smart-Standby-Wakeup, when disabling wakeup feature the
IP will not go back to Smart-Standby, but will remain in Smart-Standby-Wakeup.

Signed-off-by: Djamil Elaidi <d-elaidi@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e174c2a..a6da0b3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -530,7 +530,7 @@ static int _disable_wakeup(struct omap_hwmod *oh, u32 *v)
 	if (oh->class->sysc->idlemodes & SIDLE_SMART_WKUP)
 		_set_slave_idlemode(oh, HWMOD_IDLEMODE_SMART, v);
 	if (oh->class->sysc->idlemodes & MSTANDBY_SMART_WKUP)
-		_set_master_standbymode(oh, HWMOD_IDLEMODE_SMART_WKUP, v);
+		_set_master_standbymode(oh, HWMOD_IDLEMODE_SMART, v);
 
 	/* XXX test pwrdm_get_wken for this hwmod's subsystem */
 
