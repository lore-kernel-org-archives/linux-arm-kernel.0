From: nm@ti.com (Nishanth Menon)
Date: Thu, 17 Apr 2014 15:49:23 -0500
Subject: [PATCH V2 07/19] bus: omap_l3_noc: move L3 master data structure out
In-Reply-To: <1397767775-10965-1-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
Message-ID: <1397767775-10965-8-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the L3 master structure out of the static definition to enable
reuse for other SoCs.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
V2: no functional change, just reordering
V1: https://patchwork.kernel.org/patch/3984151/
 drivers/bus/omap_l3_noc.h |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.h b/drivers/bus/omap_l3_noc.h
index 31984cf..059c707 100644
--- a/drivers/bus/omap_l3_noc.h
+++ b/drivers/bus/omap_l3_noc.h
@@ -33,6 +33,16 @@
 
 #define NUM_OF_L3_MASTERS	(sizeof(l3_masters)/sizeof(l3_masters[0]))
 
+/**
+ * struct l3_masters_data - L3 Master information
+ * @id:		ID of the L3 Master
+ * @name:	master name
+ */
+struct l3_masters_data {
+	u32 id;
+	char *name;
+};
+
 static u32 l3_flagmux[L3_MODULES] = {
 	0x500,
 	0x1000,
@@ -80,10 +90,7 @@ static u32 l3_targ_inst_clk3[] = {
 	0x0 /* HOST CLK3 */
 };
 
-static struct l3_masters_data {
-	u32 id;
-	char name[10];
-} l3_masters[] = {
+static struct l3_masters_data l3_masters[] = {
 	{ 0x0 , "MPU"},
 	{ 0x10, "CS_ADP"},
 	{ 0x14, "xxx"},
-- 
1.7.9.5
