From: geoff@infradead.org (Geoff Levand)
Date: Thu, 03 Apr 2014 16:07:01 -0700
Subject: [PATCH arm64 bootwrapper] Fix maintainer-clean make target
Message-ID: <1396566421.4369.28.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing MAINTAINERCLEANFILES to makefile.am.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
Hi Catalin,

Here's a minor fix for the arm64 bootwrapper to make
'make maintainer-clean' work.  You can try it with
something this:

autoreconf -i
./configure ...
make maintainer-clean
git ls-files -o

-Geoff

 Makefile.am | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 5791ad1..c911e51 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -88,3 +88,6 @@ fdt.dtb: $(KERNEL_DTB) Makefile gen-cpu-nodes.sh
 
 # The filesystem archive might not exist if INITRD is not being used
 .PHONY: all clean $(FILESYSTEM)
+
+MAINTAINERCLEANFILES = aclocal.m4 compile config.* configure install-sh \
+	Makefile.in missing
-- 
1.9.1
