From: daniel.hobi@schmid-telecom.ch (Daniel Hobi)
Date: Tue, 31 Aug 2010 14:52:17 +0200
Subject: [PATCH] [ARM] .gitignore: Ignore piggy.gzip, lib1funcs.S and vmlinux
References: <1272015498-10749-1-git-send-email-mroth@nessie.de>
Message-ID: <1283259137-28480-1-git-send-email-daniel.hobi@schmid-telecom.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e7db7b42 (arm: add support for LZO-compressed kernels) added
intermediate files piggy.gzip and lib1funcs.S without adding them to
.gitignore.

Commit 6db823c (Fix up .gitignore for top-level file patterns) changed
vmlinux to /vmlinux in the top-level .gitignore, thus making
arch/arm/boot/compressed/vmlinux visible.

Signed-off-by: Daniel Hobi <daniel.hobi@schmid-telecom.ch>
---
This patch revives https://patchwork.kernel.org/patch/94654/
([ARM] .gitignore: Ignore piggy.lzo, lib1funcs.S and vmlinux)
by Michael Roth with the following changes:
 - do not add piggy.lzo because it is now covered by *.lzo rule
   from top-level .gitignore
 - Ignore piggy.gzip (instead of piggy.gz)

Please keep me on CC since I am not a subscriber.

 arch/arm/boot/compressed/.gitignore |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index ab204db..e02c52e 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -1,3 +1,5 @@
 font.c
-piggy.gz
+lib1funcs.S
+piggy.gzip
+vmlinux
 vmlinux.lds
-- 
1.7.2.1
