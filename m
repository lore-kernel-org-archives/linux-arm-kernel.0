From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 29 Jul 2013 21:24:00 +0000
Subject: [PATCH 1/2] add cscope Makefile target
In-Reply-To: <cover.1375131816.git.jason@lakedaemon.net>
References: <cover.1375131816.git.jason@lakedaemon.net>
Message-ID: <dcc21753a1bf975fc97c5f4c8d089e1fb4b00dd2.1375131816.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 .gitignore | 1 +
 Makefile   | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/.gitignore b/.gitignore
index c3b59bf..ac4198c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,6 +1,7 @@
 *.sh
 *.o
 *.bin
+cscope.*
 matcher
 uImage
 input/zImage
diff --git a/Makefile b/Makefile
index 5ad5fc0..daeafa4 100644
--- a/Makefile
+++ b/Makefile
@@ -43,3 +43,9 @@ uImage: matcher.bin
 clean:
 	rm -fr matcher.bin matcher *.o uImage
 
+distclean:
+	rm -fr cscope.*
+
+cscope:
+	-find . -name "*.[chS]" >cscope.files
+	-cscope -b -R
-- 
1.8.3.2
