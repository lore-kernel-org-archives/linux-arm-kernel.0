From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 10 Jan 2016 13:57:17 +0200
Subject: [PATCH v2 3/3] checkpatch: add virt barriers
In-Reply-To: <1452427000-4520-1-git-send-email-mst@redhat.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
Message-ID: <1452427000-4520-4-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add virt_ barriers to list of barriers to check for
presence of a comment.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a96adcb..5ca272b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5131,7 +5131,8 @@ sub process {
 		}x;
 		my $all_barriers = qr{
 			$barriers|
-			smp_($smp_barriers)
+			smp_($smp_barriers)|
+			virt_($smp_barriers)
 		}x;
 
 		if ($line =~ /\b($all_barriers)\s*\(/) {
-- 
MST
