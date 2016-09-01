From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 1 Sep 2016 14:55:06 +0800
Subject: [PATCH v8 15/16] Documentation: remove the constraint on the
 distances of node pairs
In-Reply-To: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1472712907-12700-16-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At present, the distances must equal in both direction for each node
pairs. For example: the distance of node B->A must the same to A->B.
But we really don't have to do this.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/numa.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
index 21b3505..f7234cd 100644
--- a/Documentation/devicetree/bindings/numa.txt
+++ b/Documentation/devicetree/bindings/numa.txt
@@ -48,15 +48,19 @@ distance (memory latency) between all numa nodes.

   Note:
 	1. Each entry represents distance from first node to second node.
-	The distances are equal in either direction.
 	2. The distance from a node to self (local distance) is represented
 	with value 10 and all internode distance should be represented with
 	a value greater than 10.
-	3. distance-matrix should have entries in lexicographical ascending
+	3. For non-local node pairs:
+	  1) If both direction specified, keep no change.
+	  2) If only one direction specified, assign it to the other direction.
+	  3) If none of the two direction specified, both are assigned to
+	     REMOTE_DISTANCE.
+	4. distance-matrix should have entries in lexicographical ascending
 	order of nodes.
-	4. There must be only one device node distance-map which must
+	5. There must be only one device node distance-map which must
 	reside in the root node.
-	5. If the distance-map node is not present, a default
+	6. If the distance-map node is not present, a default
 	distance-matrix is used.

 Example:
--
2.5.0
