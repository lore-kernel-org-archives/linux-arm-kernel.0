From: balbi@ti.com (Felipe Balbi)
Date: Tue, 11 Dec 2012 19:04:56 +0200
Subject: [PATCH] arm: omap: add read permission to mux debugfs files
Message-ID: <1355245496-19180-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All those files provide a ->read() method on their
file_operations structure.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 2612634..6701f31 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -742,8 +742,8 @@ static void __init omap_mux_dbg_create_entry(
 	list_for_each_entry(e, &partition->muxmodes, node) {
 		struct omap_mux *m = &e->mux;
 
-		(void)debugfs_create_file(m->muxnames[0], S_IWUSR, mux_dbg_dir,
-					  m, &omap_mux_dbg_signal_fops);
+		(void)debugfs_create_file(m->muxnames[0], S_IWUSR | S_IRUSR,
+				mux_dbg_dir, m, &omap_mux_dbg_signal_fops);
 	}
 }
 
-- 
1.8.1.rc1.5.g7e0651a
