From: andrej.skvortzov@gmail.com (Andrey Skvortsov)
Date: Tue, 28 Apr 2015 23:32:00 +0300
Subject: [PATCH] arm: vdso: .gitignore: ignore generated vdso.so.raw and
 vdsomunge
Message-ID: <1430253120-27568-1-git-send-email-andrej.skvortzov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After kernel is built 'git status' reports:

 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
 #
 #        arch/arm/vdso/vdso.so.raw
 #        arch/arm/vdso/vdsomunge

These files are created during build process and removed with 'make
clean'. This patch makes git to ignore them.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 arch/arm/vdso/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/vdso/.gitignore b/arch/arm/vdso/.gitignore
index f8b69d8..6b47f6e 100644
--- a/arch/arm/vdso/.gitignore
+++ b/arch/arm/vdso/.gitignore
@@ -1 +1,3 @@
 vdso.lds
+vdso.so.raw
+vdsomunge
-- 
2.1.4
