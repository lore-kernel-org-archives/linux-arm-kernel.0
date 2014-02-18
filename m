From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 18 Feb 2014 14:46:27 +0800
Subject: [PATCH 1/5] ARM: prima2: l2x0: fix checkpatch issues
In-Reply-To: <1392705991-29967-1-git-send-email-21cnbao@gmail.com>
References: <1392705991-29967-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1392705991-29967-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Fix the below checkpatch issues:

ERROR: open brace '{' following struct go on the same line
15: FILE: l2x0.c:15:
+struct l2x0_aux
+{

ERROR: Use of __initconst requires a separate use of const
20: FILE: l2x0.c:20:
+static struct l2x0_aux prima2_l2x0_aux __initconst = {

ERROR: Use of __initconst requires a separate use of const
25: FILE: l2x0.c:25:
+static struct l2x0_aux marco_l2x0_aux __initconst = {

ERROR: Use of __initconst requires a separate use of const
31: FILE: l2x0.c:31:
+static struct of_device_id sirf_l2x0_ids[] __initconst = {

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/l2x0.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
index cbcbe9c..c710253 100644
--- a/arch/arm/mach-prima2/l2x0.c
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -11,24 +11,23 @@
 #include <linux/of.h>
 #include <asm/hardware/cache-l2x0.h>
 
-struct l2x0_aux
-{
+struct l2x0_aux {
 	u32 val;
 	u32 mask;
 };
 
-static struct l2x0_aux prima2_l2x0_aux __initconst = {
+static const struct l2x0_aux prima2_l2x0_aux __initconst = {
 	.val = 2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT,
 	.mask =	0,
 };
 
-static struct l2x0_aux marco_l2x0_aux __initconst = {
+static const struct l2x0_aux marco_l2x0_aux __initconst = {
 	.val = (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
 		(1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT),
 	.mask = L2X0_AUX_CTRL_MASK,
 };
 
-static struct of_device_id sirf_l2x0_ids[] __initconst = {
+static const struct of_device_id sirf_l2x0_ids[] __initconst = {
 	{ .compatible = "sirf,prima2-pl310-cache", .data = &prima2_l2x0_aux, },
 	{ .compatible = "sirf,marco-pl310-cache", .data = &marco_l2x0_aux, },
 	{},
-- 
1.7.5.4
