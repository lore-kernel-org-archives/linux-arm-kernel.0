From: dhowells@redhat.com (David Howells)
Date: Wed, 14 Mar 2012 14:18:08 +0000
Subject: [PATCH] ARM: Fix missing linux/types.h #inclusion in
 asm/hardware/iop3xx.h
Message-ID: <20120314141808.2354.62573.stgit@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/include/asm/hardware/iop3xx.h needs to include linux/types.h to avoid
the following errors:

In file included from arch/arm/plat-iop/restart.c:10:0:
/data/fs/linux-2.6-fscache/arch/arm/include/asm/hardware/iop3xx.h:239:1: error: unknown type name 'u32'
/data/fs/linux-2.6-fscache/arch/arm/include/asm/hardware/iop3xx.h: In function 'read_tmr0':
/data/fs/linux-2.6-fscache/arch/arm/include/asm/hardware/iop3xx.h:241:2: error: unknown type name 'u32'
/data/fs/linux-2.6-fscache/arch/arm/include/asm/hardware/iop3xx.h: At top level:
/data/fs/linux-2.6-fscache/arch/arm/include/asm/hardware/iop3xx.h:246:31: error: unknown type name 'u32'
...

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/arm/include/asm/hardware/iop3xx.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/iop3xx.h b/arch/arm/include/asm/hardware/iop3xx.h
index 077c323..2ff2c75 100644
--- a/arch/arm/include/asm/hardware/iop3xx.h
+++ b/arch/arm/include/asm/hardware/iop3xx.h
@@ -231,6 +231,9 @@ extern int iop3xx_get_init_atu(void);
 
 
 #ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
 void iop3xx_map_io(void);
 void iop_init_cp6_handler(void);
 void iop_init_time(unsigned long tickrate);
