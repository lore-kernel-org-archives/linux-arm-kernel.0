From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 29 Aug 2012 07:35:23 +0200
Subject: [PATCH] ARM: Build dtb files in all target
Message-ID: <1346218523-15958-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tools like kisskb are good at finding build regressions in the kernel
sources. However, regressions in the DT desscriptions are not found,
because generally these build systems don't build the DT binary blobs.

Extend the ARM all target to build all enabled DTB files.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30eae87..aee2b1e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -268,7 +268,7 @@ else
 KBUILD_IMAGE := zImage
 endif
 
-all:	$(KBUILD_IMAGE)
+all:	$(KBUILD_IMAGE) dtbs
 
 boot := arch/arm/boot
 
-- 
1.7.10.4
