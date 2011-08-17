From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:51:36 +0100
Subject: [PATCH 01/10] ARM: io: s3c2410: remove ioaddr()
In-Reply-To: <20110817075104.GC1006@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
Message-ID: <E1QtauW-0007Mg-6Z@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is only one user of ioaddr() in the kernel, and that is the Acorn
expansion card core code.  S3C2410 does not use this code, and so the
definition of ioaddr() is redundant.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-s3c2410/include/mach/io.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/io.h b/arch/arm/mach-s3c2410/include/mach/io.h
index 9813dbf..118749f 100644
--- a/arch/arm/mach-s3c2410/include/mach/io.h
+++ b/arch/arm/mach-s3c2410/include/mach/io.h
@@ -199,8 +199,6 @@ DECLARE_IO(int,l,"")
 #define outw(v,p)	(__builtin_constant_p((p)) ? __outwc(v,p) : __outw(v,p))
 #define outl(v,p)	(__builtin_constant_p((p)) ? __outlc(v,p) : __outl(v,p))
 #define __ioaddr(p)	(__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
-/* the following macro is deprecated */
-#define ioaddr(port)	__ioaddr((port))
 
 #define insb(p,d,l)	__raw_readsb(__ioaddr(p),d,l)
 #define insw(p,d,l)	__raw_readsw(__ioaddr(p),d,l)
-- 
1.7.4.4
