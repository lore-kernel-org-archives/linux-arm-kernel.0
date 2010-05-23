From: redhatter@gentoo.org (Stuart Longland)
Date: Sun, 23 May 2010 11:40:56 +1000
Subject: [PATCH] Ignore generated files in arch/arm/boot/compressed
Message-ID: <20100523014056.GF18017@www.longlandclan.yi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This tells git to ignore files produced when compiling kernels for ARM, fixing
this annoying message:

	stuartl at zhouman ~/jacques/linux $ git status
	# On branch experiment
	# Untracked files:
	#   (use "git add <file>..." to include in what will be committed)
	#
	#       arch/arm/boot/compressed/lib1funcs.S
	#       arch/arm/boot/compressed/piggy.gzip
	#       arch/arm/boot/compressed/vmlinux
	nothing added to commit but untracked files present (use "git add" to track)

Signed-off-by: Stuart Longland <redhatter@gentoo.org>
---
 arch/arm/boot/compressed/.gitignore |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index ab204db..7ce0ce9 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,3 +1,5 @@
 font.c
-piggy.gz
+lib1funcs.S
+piggy.*
 vmlinux.lds
+vmlinux
-- 
1.6.4
