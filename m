From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 10 Jan 2016 21:31:00 +0200
Subject: [PATCH v3 3/3] checkpatch: add virt barriers
In-Reply-To: <1452454200-8844-1-git-send-email-mst@redhat.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
Message-ID: <1452454200-8844-4-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add virt_ barriers to list of barriers to check for
presence of a comment.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 15cfca4..4466579 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5133,7 +5133,8 @@ sub process {
 		}x;
 		my $all_barriers = qr{
 			$barriers|
-			smp_(?:$smp_barrier_stems)
+			smp_(?:$smp_barrier_stems)|
+			virt_(?:$smp_barrier_stems)
 		}x;
 
 		if ($line =~ /\b(?:$all_barriers)\s*\(/) {
-- 
MST
