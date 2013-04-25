From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 19:29:00 +0200
Subject: [PATCH 17/21] X.509: do not emit any informational output
In-Reply-To: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
Message-ID: <1366910944-3033663-18-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a kernel using 'make -s', I expect to see an empty output,
except for build warnings and errors. The build_OID_registry code
always prints one line when run, which is not helpful to most people
building the kernels, and which makes it harder to automatically
check for build warnings.

Let's just remove the one line output.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
---
 lib/build_OID_registry | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/build_OID_registry b/lib/build_OID_registry
index dfbdaab..5d98272 100755
--- a/lib/build_OID_registry
+++ b/lib/build_OID_registry
@@ -50,8 +50,6 @@ my @indices = ();
 my @lengths = ();
 my $total_length = 0;
 
-print "Compiling ", $#names + 1, " OIDs\n";
-
 for (my $i = 0; $i <= $#names; $i++) {
     my $name = $names[$i];
     my $oid = $oids[$i];
-- 
1.8.1.2
