From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 5 Mar 2011 11:31:04 +0000
Subject: [PATCH] [ARM] orion5x: fix compiler cast warnings in ts78xx-setup.c
Message-ID: <20110305113104.GB22117@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/mach-orion5x/ts78xx-setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 82e57a6..78e3b9a 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -200,7 +200,7 @@ static void ts78xx_ts_nand_write_buf(struct mtd_info *mtd,
 	int sz;
 
 	if (off) {
-		sz = min(4 - off, len);
+		sz = min((int) (4 - off), len);
 		writesb(io_base, buf, sz);
 		buf += sz;
 		len -= sz;
@@ -227,7 +227,7 @@ static void ts78xx_ts_nand_read_buf(struct mtd_info *mtd,
 	int sz;
 
 	if (off) {
-		sz = min(4 - off, len);
+		sz = min((int) (4 - off), len);
 		readsb(io_base, buf, sz);
 		buf += sz;
 		len -= sz;
-- 
1.7.4.1
