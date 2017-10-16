From: joe@perches.com (Joe Perches)
Date: Mon, 16 Oct 2017 09:12:00 -0700
Subject: [PATCH] checkpatch: Allow DEFINE_PER_CPU definitions to exceed line
 length
In-Reply-To: <20171016152839.14964-3-mark.rutland@arm.com>
References: <20171016152839.14964-1-mark.rutland@arm.com>
 <20171016152839.14964-3-mark.rutland@arm.com>
Message-ID: <1508170320.6530.15.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the definitions are very long and can't be split
into multiple lines because ctags is limited.

Exempt these lines from the line length checks.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2a8c6c3c1bdb..5fa0f5467d99 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2900,8 +2900,9 @@ sub process {
 				 $line =~ /^\+\s*#\s*define\s+\w+\s+$String$/) {
 				$msg_type = "";
 
-			# EFI_GUID is another special case
-			} elsif ($line =~ /^\+.*\bEFI_GUID\s*\(/) {
+			# More special cases
+			} elsif ($line =~ /^\+.*\bEFI_GUID\s*\(/ ||
+				 $line =~ /^\+\s*(?:\w+)?\s*DEFINE_PER_CPU/) {
 				$msg_type = "";
 
 			# Otherwise set the alternate message types
