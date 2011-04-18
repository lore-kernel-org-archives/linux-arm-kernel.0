From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 18 Apr 2011 13:19:36 +0800
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
Message-ID: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If AUTO_ZRELADDR is selected and target is not uImage, the existence
of Makefile.boot could be optional.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 9128fdd..277368f 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -14,7 +14,7 @@
 MKIMAGE         := $(srctree)/scripts/mkuboot.sh
 
 ifneq ($(MACHINE),)
-include $(srctree)/$(MACHINE)/Makefile.boot
+-include $(srctree)/$(MACHINE)/Makefile.boot
 endif
 
 # Note: the following conditions must always be true:
-- 
1.7.1
