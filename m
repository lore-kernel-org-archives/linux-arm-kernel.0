From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue,  2 Aug 2011 16:33:27 +0100
Subject: [PATCH] fix for: Build a uImage with dtb already appended
In-Reply-To: <20110802143148.21599.22870.stgit@ponder>
References: <20110802143148.21599.22870.stgit@ponder>
Message-ID: <1312299207-12735-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/boot/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index a64493b..68d6f23 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -75,8 +75,10 @@ quiet_cmd_uimage = UIMAGE  $@
 
 ifeq ($(CONFIG_ZBOOT_ROM),y)
 $(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
+$(obj)/uImage-dtb.%: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
 else
 $(obj)/uImage: LOADADDR=$(ZRELADDR)
+$(obj)/uImage-dtb.%: LOADADDR=$(ZRELADDR)
 endif
 
 $(obj)/uImage: STARTADDR=$(LOADADDR)
-- 
1.7.4.1
