From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jul 2017 17:53:45 +0200
Subject: [PATCH 12/12] ARM: rpc: rename RAM_SIZE macro
In-Reply-To: <20170720154616.3250481-1-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
Message-ID: <20170720155410.3251043-3-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RAM_SIZE macro in mach/hardware.h conflicts with macros of
the same name in multiple drivers, leading to annoying build warnings:

In file included from drivers/net/ethernet/cirrus/cs89x0.c:79:0:
drivers/net/ethernet/cirrus/cs89x0.h:324:0: error: "RAM_SIZE" redefined [-Werror]
 #define RAM_SIZE 0x1000       /*  The card has 4k bytes or RAM */
 ^
In file included from /git/arm-soc/arch/arm/mach-rpc/include/mach/io.h:16:0,
                 from /git/arm-soc/arch/arm/include/asm/io.h:194,
                 from /git/arm-soc/include/linux/scatterlist.h:8,
                 from /git/arm-soc/include/linux/dmaengine.h:24,
                 from /git/arm-soc/include/linux/netdevice.h:38,
                 from /git/arm-soc/drivers/net/ethernet/cirrus/cs89x0.c:54:
arch/arm/mach-rpc/include/mach/hardware.h:28:0: note: this is the location of the previous definition
 #define RAM_SIZE  0x10000000

We don't use RAM_SIZE/RAM_START at all, so we could just remove
them, but it might be nice to leave them for documentation purposes,
so this renames them to RPC_RAM_SIZE/RPC_RAM_START in order to
avoid the build warnings

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I originally sent this in Feb 2016, but it got lost for some reason.
---
 arch/arm/mach-rpc/include/mach/hardware.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rpc/include/mach/hardware.h b/arch/arm/mach-rpc/include/mach/hardware.h
index aa79fa47373a..622d4e5df029 100644
--- a/arch/arm/mach-rpc/include/mach/hardware.h
+++ b/arch/arm/mach-rpc/include/mach/hardware.h
@@ -25,8 +25,8 @@
  *  *_SIZE  is the size of the region
  *  *_BASE  is the virtual address
  */
-#define RAM_SIZE		0x10000000
-#define RAM_START		0x10000000
+#define RPC_RAM_SIZE		0x10000000
+#define RPC_RAM_START		0x10000000
 
 #define EASI_SIZE		0x08000000	/* EASI I/O */
 #define EASI_START		0x08000000
-- 
2.9.0
