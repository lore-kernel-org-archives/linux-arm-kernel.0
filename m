From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Mar 2018 14:11:18 +1100
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20180313141118.41cd6419@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  drivers/bus/arm-cci.c

between commit:

  3de6be7a3dd8 ("drivers/bus: Split Arm CCI driver")

from the arm-soc tree and commit:

  8343aae66167 ("perf/core: Remove perf_event::group_entry")

from the tip tree.

I fixed it up (I have added the following merge fix patch) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 13 Mar 2018 14:08:01 +1100
Subject: [PATCH] perf/core: merge fix for "drivers/bus: Split Arm CCI driver"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/perf/arm-cci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 67a74c48c7c2..192d23b760a0 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1265,7 +1265,7 @@ static int validate_group(struct perf_event *event)
 	if (!validate_event(event->pmu, &fake_pmu, leader))
 		return -EINVAL;
 
-	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
+	list_for_each_entry(sibling, &leader->sibling_list, sibling_list) {
 		if (!validate_event(event->pmu, &fake_pmu, sibling))
 			return -EINVAL;
 	}
-- 
2.16.1

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180313/157fa9f6/attachment.sig>
