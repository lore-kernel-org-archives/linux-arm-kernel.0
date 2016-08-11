From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 11 Aug 2016 21:36:48 +0800
Subject: [PATCH v2 3/4] arm64: kaslr: Fix incorrect placement of __initdata
 and __read_mostly
In-Reply-To: <1470922609-754-1-git-send-email-jszhang@marvell.com>
References: <1470922609-754-1-git-send-email-jszhang@marvell.com>
Message-ID: <1470922609-754-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata and __read_mostly should be placed after the variable name
for the variable to be placed in the intended section.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index b054691..8ebabc4 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -20,8 +20,8 @@
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 
-u64 __read_mostly module_alloc_base;
-u16 __initdata memstart_offset_seed;
+u64 module_alloc_base __read_mostly;
+u16 memstart_offset_seed __initdata;
 
 static __init u64 get_kaslr_seed(void *fdt)
 {
-- 
2.8.1
