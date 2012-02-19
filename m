From: neilb@suse.de (NeilBrown)
Date: Sun, 19 Feb 2012 13:29:31 +1100
Subject: [PATCH 2/2] ARM: OMAP2: remove some orphan function declarations.
In-Reply-To: <20120219022841.8254.86264.stgit@notabene.brown>
References: <20120219022841.8254.86264.stgit@notabene.brown>
Message-ID: <20120219022931.8254.29652.stgit@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 2fd149645eb removed omap_uart_can_sleep and omap3_can_sleep,
but not their declarations.  So remove those now.

Signed-off-by: NeilBrown <neilb@suse.de>
---

 arch/arm/mach-omap2/pm.h                 |    1 -
 arch/arm/plat-omap/include/plat/serial.h |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b737b11..6cd954d 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -18,7 +18,6 @@
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
-extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 extern int omap4_idle_init(void);
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 198d1e6..b073e5f 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -110,7 +110,6 @@ struct omap_board_data;
 struct omap_uart_port_info;
 
 extern void omap_serial_init(void);
-extern int omap_uart_can_sleep(void);
 extern void omap_serial_board_init(struct omap_uart_port_info *platform_data);
 extern void omap_serial_init_port(struct omap_board_data *bdata,
 		struct omap_uart_port_info *platform_data);
