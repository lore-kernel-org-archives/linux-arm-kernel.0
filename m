From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 19 Feb 2010 12:29:46 -0700
Subject: [PATCH 7/7] arm/boot/hack: set uImage load address to 0x81000000
In-Reply-To: <20100219185953.15318.4850.stgit@angua>
References: <20100219185953.15318.4850.stgit@angua>
Message-ID: <20100219192905.15318.30916.stgit@angua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Total hack.
Don't merge.
This will go away when I fix patch 6/7

g.

---

 arch/arm/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 4a590f4..9aeea2f 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -67,7 +67,7 @@ quiet_cmd_uimage = UIMAGE  $@
 ifeq ($(CONFIG_ZBOOT_ROM),y)
 $(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
 else
-$(obj)/uImage: LOADADDR=$(ZRELADDR)
+$(obj)/uImage: LOADADDR=0x81000000
 endif
 
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
