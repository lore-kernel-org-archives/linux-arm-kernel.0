From: mst@redhat.com (Michael S. Tsirkin)
Date: Mon, 11 Jan 2016 13:00:40 +0200
Subject: [PATCH v4 3/3] checkpatch: add virt barriers
In-Reply-To: <1452509968-19778-1-git-send-email-mst@redhat.com>
References: <1452509968-19778-1-git-send-email-mst@redhat.com>
Message-ID: <1452509968-19778-4-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add virt_ barriers to list of barriers to check for
presence of a comment.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25476c2..c7bf1aa 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5133,7 +5133,8 @@ sub process {
 		}x;
 		my $all_barriers = qr{
 			(?:$barriers)|
-			smp_(?:$barrier_stems)
+			smp_(?:$barrier_stems)|
+			virt_(?:$barrier_stems)
 		}x;
 
 		if ($line =~ /\b(?:$all_barriers)\s*\(/) {
-- 
MST
