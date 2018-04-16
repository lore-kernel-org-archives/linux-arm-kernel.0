From: dave.anglin@bell.net (John David Anglin)
Date: Mon, 16 Apr 2018 19:37:53 -0400
Subject: [PATCH 1/2] parisc: use the asm-generic version for writeX()
In-Reply-To: <a7b59f43-cea5-0ead-f528-61899570e353@codeaurora.org>
References: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
 <a727e74f-610c-4722-76e9-c1aca2f9e9bd@bell.net>
 <a7b59f43-cea5-0ead-f528-61899570e353@codeaurora.org>
Message-ID: <7a9d139e-978b-750d-1bac-8b27e934f781@bell.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-16 7:15 PM, Sinan Kaya wrote:
> Thanks for testing. Can you add this on top and see if it helps?
>
> --- a/arch/parisc/include/asm/io.h
> +++ b/arch/parisc/include/asm/io.h
> @@ -259,6 +259,7 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
>    * value for either 32 or 64 bit mode */
>   #define F_EXTEND(x) ((unsigned long)((x) | (0xffffffff00000000ULL)))
>   
> +#include <asm-generic/io.h>
>   #include <asm-generic/iomap.h>
Still lots of problems.

Dave

-- 
John David Anglin  dave.anglin at bell.net

-------------- next part --------------
  CC      arch/parisc/kernel/asm-offsets.s
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:37:21: error: redefinition of '__raw_readb'
 #define __raw_readb __raw_readb
                     ^
./include/asm-generic/io.h:38:18: note: in expansion of macro '__raw_readb'
 static inline u8 __raw_readb(const volatile void __iomem *addr)
                  ^~~~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:146:29: note: previous definition of '__raw_readb' was here
 static inline unsigned char __raw_readb(const volatile void __iomem *addr)
                             ^~~~~~~~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:45:21: error: redefinition of '__raw_readw'
 #define __raw_readw __raw_readw
                     ^
./include/asm-generic/io.h:46:19: note: in expansion of macro '__raw_readw'
 static inline u16 __raw_readw(const volatile void __iomem *addr)
                   ^~~~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:150:30: note: previous definition of '__raw_readw' was here
 static inline unsigned short __raw_readw(const volatile void __iomem *addr)
                              ^~~~~~~~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:53:21: error: redefinition of '__raw_readl'
 #define __raw_readl __raw_readl
                     ^
./include/asm-generic/io.h:54:19: note: in expansion of macro '__raw_readl'
 static inline u32 __raw_readl(const volatile void __iomem *addr)
                   ^~~~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:154:28: note: previous definition of '__raw_readl' was here
 static inline unsigned int __raw_readl(const volatile void __iomem *addr)
                            ^~~~~~~~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:62:21: error: redefinition of '__raw_readq'
 #define __raw_readq __raw_readq
                     ^
./include/asm-generic/io.h:63:19: note: in expansion of macro '__raw_readq'
 static inline u64 __raw_readq(const volatile void __iomem *addr)
                   ^~~~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:158:34: note: previous definition of '__raw_readq' was here
 static inline unsigned long long __raw_readq(const volatile void __iomem *addr)
                                  ^~~~~~~~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:71:22: error: redefinition of '__raw_writeb'
 #define __raw_writeb __raw_writeb
                      ^
./include/asm-generic/io.h:72:20: note: in expansion of macro '__raw_writeb'
 static inline void __raw_writeb(u8 value, volatile void __iomem *addr)
                    ^~~~~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:163:20: note: previous definition of '__raw_writeb' was here
 static inline void __raw_writeb(unsigned char b, volatile void __iomem *addr)
                    ^~~~~~~~~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:79:22: error: redefinition of '__raw_writew'
 #define __raw_writew __raw_writew
                      ^
./include/asm-generic/io.h:80:20: note: in expansion of macro '__raw_writew'
 static inline void __raw_writew(u16 value, volatile void __iomem *addr)
                    ^~~~~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:167:20: note: previous definition of '__raw_writew' was here
 static inline void __raw_writew(unsigned short b, volatile void __iomem *addr)
                    ^~~~~~~~~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:87:22: error: redefinition of '__raw_writel'
 #define __raw_writel __raw_writel
                      ^
./include/asm-generic/io.h:88:20: note: in expansion of macro '__raw_writel'
 static inline void __raw_writel(u32 value, volatile void __iomem *addr)
                    ^~~~~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:171:20: note: previous definition of '__raw_writel' was here
 static inline void __raw_writel(unsigned int b, volatile void __iomem *addr)
                    ^~~~~~~~~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:96:22: error: redefinition of '__raw_writeq'
 #define __raw_writeq __raw_writeq
                      ^
./include/asm-generic/io.h:97:20: note: in expansion of macro '__raw_writeq'
 static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
                    ^~~~~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:175:20: note: previous definition of '__raw_writeq' was here
 static inline void __raw_writeq(unsigned long long b, volatile void __iomem *addr)
                    ^~~~~~~~~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:361:13: error: conflicting types for 'inb'
 #define inb inb
             ^
./include/asm-generic/io.h:362:18: note: in expansion of macro 'inb'
 static inline u8 inb(unsigned long addr)
                  ^~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:203:22: note: previous declaration of 'inb' was here
 extern unsigned char inb(int addr);
                      ^~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:369:13: error: conflicting types for 'inw'
 #define inw inw
             ^
./include/asm-generic/io.h:370:19: note: in expansion of macro 'inw'
 static inline u16 inw(unsigned long addr)
                   ^~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:204:23: note: previous declaration of 'inw' was here
 extern unsigned short inw(int addr);
                       ^~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:377:13: error: conflicting types for 'inl'
 #define inl inl
             ^
./include/asm-generic/io.h:378:19: note: in expansion of macro 'inl'
 static inline u32 inl(unsigned long addr)
                   ^~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:205:21: note: previous declaration of 'inl' was here
 extern unsigned int inl(int addr);
                     ^~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:385:14: error: conflicting types for 'outb'
 #define outb outb
              ^
./include/asm-generic/io.h:386:20: note: in expansion of macro 'outb'
 static inline void outb(u8 value, unsigned long addr)
                    ^~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:207:13: note: previous declaration of 'outb' was here
 extern void outb(unsigned char b, int addr);
             ^~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:393:14: error: conflicting types for 'outw'
 #define outw outw
              ^
./include/asm-generic/io.h:394:20: note: in expansion of macro 'outw'
 static inline void outw(u16 value, unsigned long addr)
                    ^~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:208:13: note: previous declaration of 'outw' was here
 extern void outw(unsigned short b, int addr);
             ^~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:401:14: error: conflicting types for 'outl'
 #define outl outl
              ^
./include/asm-generic/io.h:402:20: note: in expansion of macro 'outl'
 static inline void outl(u32 value, unsigned long addr)
                    ^~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:209:13: note: previous declaration of 'outl' was here
 extern void outl(unsigned int b, int addr);
             ^~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:462:14: error: conflicting types for 'insb'
 #define insb insb
              ^
./include/asm-generic/io.h:463:20: note: in expansion of macro 'insb'
 static inline void insb(unsigned long addr, void *buffer, unsigned int count)
                    ^~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:244:13: note: previous declaration of 'insb' was here
 extern void insb (unsigned long port, void *dst, unsigned long count);
             ^~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:470:14: error: conflicting types for 'insw'
 #define insw insw
              ^
./include/asm-generic/io.h:471:20: note: in expansion of macro 'insw'
 static inline void insw(unsigned long addr, void *buffer, unsigned int count)
                    ^~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:245:13: note: previous declaration of 'insw' was here
 extern void insw (unsigned long port, void *dst, unsigned long count);
             ^~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:478:14: error: conflicting types for 'insl'
 #define insl insl
              ^
./include/asm-generic/io.h:479:20: note: in expansion of macro 'insl'
 static inline void insl(unsigned long addr, void *buffer, unsigned int count)
                    ^~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:246:13: note: previous declaration of 'insl' was here
 extern void insl (unsigned long port, void *dst, unsigned long count);
             ^~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:486:15: error: conflicting types for 'outsb'
 #define outsb outsb
               ^
./include/asm-generic/io.h:487:20: note: in expansion of macro 'outsb'
 static inline void outsb(unsigned long addr, const void *buffer,
                    ^~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:247:13: note: previous declaration of 'outsb' was here
 extern void outsb (unsigned long port, const void *src, unsigned long count);
             ^~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:495:15: error: conflicting types for 'outsw'
 #define outsw outsw
               ^
./include/asm-generic/io.h:496:20: note: in expansion of macro 'outsw'
 static inline void outsw(unsigned long addr, const void *buffer,
                    ^~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:248:13: note: previous declaration of 'outsw' was here
 extern void outsw (unsigned long port, const void *src, unsigned long count);
             ^~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:504:15: error: conflicting types for 'outsl'
 #define outsl outsl
               ^
./include/asm-generic/io.h:505:20: note: in expansion of macro 'outsl'
 static inline void outsl(unsigned long addr, const void *buffer,
                    ^~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:249:13: note: previous declaration of 'outsl' was here
 extern void outsl (unsigned long port, const void *src, unsigned long count);
             ^~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:959:19: error: conflicting types for 'memset_io'
 #define memset_io memset_io
                   ^
./include/asm-generic/io.h:968:20: note: in expansion of macro 'memset_io'
 static inline void memset_io(volatile void __iomem *addr, int value,
                    ^~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:182:6: note: previous declaration of 'memset_io' was here
 void memset_io(volatile void __iomem *addr, unsigned char val, int count);
      ^~~~~~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:976:23: error: conflicting types for 'memcpy_fromio'
 #define memcpy_fromio memcpy_fromio
                       ^
./include/asm-generic/io.h:985:20: note: in expansion of macro 'memcpy_fromio'
 static inline void memcpy_fromio(void *buffer,
                    ^~~~~~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:183:6: note: previous declaration of 'memcpy_fromio' was here
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
      ^~~~~~~~~~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:994:21: error: conflicting types for 'memcpy_toio'
 #define memcpy_toio memcpy_toio
                     ^
./include/asm-generic/io.h:1003:20: note: in expansion of macro 'memcpy_toio'
 static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
                    ^~~~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:184:6: note: previous declaration of 'memcpy_toio' was here
 void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
      ^~~~~~~~~~~
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:565:17: error: conflicting types for 'ioread8'
 #define ioread8 ioread8
                 ^
./include/asm-generic/iomap.h:29:21: note: in expansion of macro 'ioread8'
 extern unsigned int ioread8(void __iomem *);
                     ^~~~~~~
./include/asm-generic/io.h:565:17: note: previous definition of 'ioread8' was here
 #define ioread8 ioread8
                 ^
./include/asm-generic/io.h:566:18: note: in expansion of macro 'ioread8'
 static inline u8 ioread8(const volatile void __iomem *addr)
                  ^~~~~~~
./include/asm-generic/io.h:573:18: error: conflicting types for 'ioread16'
 #define ioread16 ioread16
                  ^
./include/asm-generic/iomap.h:30:21: note: in expansion of macro 'ioread16'
 extern unsigned int ioread16(void __iomem *);
                     ^~~~~~~~
./include/asm-generic/io.h:573:18: note: previous definition of 'ioread16' was here
 #define ioread16 ioread16
                  ^
./include/asm-generic/io.h:574:19: note: in expansion of macro 'ioread16'
 static inline u16 ioread16(const volatile void __iomem *addr)
                   ^~~~~~~~
./include/asm-generic/io.h:633:20: error: conflicting types for 'ioread16be'
 #define ioread16be ioread16be
                    ^
./include/asm-generic/iomap.h:31:21: note: in expansion of macro 'ioread16be'
 extern unsigned int ioread16be(void __iomem *);
                     ^~~~~~~~~~
./include/asm-generic/io.h:633:20: note: previous definition of 'ioread16be' was here
 #define ioread16be ioread16be
                    ^
./include/asm-generic/io.h:634:19: note: in expansion of macro 'ioread16be'
 static inline u16 ioread16be(const volatile void __iomem *addr)
                   ^~~~~~~~~~
./include/asm-generic/io.h:581:18: error: conflicting types for 'ioread32'
 #define ioread32 ioread32
                  ^
./include/asm-generic/iomap.h:32:21: note: in expansion of macro 'ioread32'
 extern unsigned int ioread32(void __iomem *);
                     ^~~~~~~~
./include/asm-generic/io.h:581:18: note: previous definition of 'ioread32' was here
 #define ioread32 ioread32
                  ^
./include/asm-generic/io.h:582:19: note: in expansion of macro 'ioread32'
 static inline u32 ioread32(const volatile void __iomem *addr)
                   ^~~~~~~~
./include/asm-generic/io.h:641:20: error: conflicting types for 'ioread32be'
 #define ioread32be ioread32be
                    ^
./include/asm-generic/iomap.h:33:21: note: in expansion of macro 'ioread32be'
 extern unsigned int ioread32be(void __iomem *);
                     ^~~~~~~~~~
./include/asm-generic/io.h:641:20: note: previous definition of 'ioread32be' was here
 #define ioread32be ioread32be
                    ^
./include/asm-generic/io.h:642:19: note: in expansion of macro 'ioread32be'
 static inline u32 ioread32be(const volatile void __iomem *addr)
                   ^~~~~~~~~~
./include/asm-generic/io.h:590:18: error: conflicting types for 'ioread64'
 #define ioread64 ioread64
                  ^
./include/asm-generic/iomap.h:35:12: note: in expansion of macro 'ioread64'
 extern u64 ioread64(void __iomem *);
            ^~~~~~~~
./include/asm-generic/io.h:590:18: note: previous definition of 'ioread64' was here
 #define ioread64 ioread64
                  ^
./include/asm-generic/io.h:591:19: note: in expansion of macro 'ioread64'
 static inline u64 ioread64(const volatile void __iomem *addr)
                   ^~~~~~~~
./include/asm-generic/io.h:650:20: error: conflicting types for 'ioread64be'
 #define ioread64be ioread64be
                    ^
./include/asm-generic/iomap.h:36:12: note: in expansion of macro 'ioread64be'
 extern u64 ioread64be(void __iomem *);
            ^~~~~~~~~~
./include/asm-generic/io.h:650:20: note: previous definition of 'ioread64be' was here
 #define ioread64be ioread64be
                    ^
./include/asm-generic/io.h:651:19: note: in expansion of macro 'ioread64be'
 static inline u64 ioread64be(const volatile void __iomem *addr)
                   ^~~~~~~~~~
./include/asm-generic/io.h:599:18: error: conflicting types for 'iowrite8'
 #define iowrite8 iowrite8
                  ^
./include/asm-generic/iomap.h:39:13: note: in expansion of macro 'iowrite8'
 extern void iowrite8(u8, void __iomem *);
             ^~~~~~~~
./include/asm-generic/io.h:599:18: note: previous definition of 'iowrite8' was here
 #define iowrite8 iowrite8
                  ^
./include/asm-generic/io.h:600:20: note: in expansion of macro 'iowrite8'
 static inline void iowrite8(u8 value, volatile void __iomem *addr)
                    ^~~~~~~~
./include/asm-generic/io.h:607:19: error: conflicting types for 'iowrite16'
 #define iowrite16 iowrite16
                   ^
./include/asm-generic/iomap.h:40:13: note: in expansion of macro 'iowrite16'
 extern void iowrite16(u16, void __iomem *);
             ^~~~~~~~~
./include/asm-generic/io.h:607:19: note: previous definition of 'iowrite16' was here
 #define iowrite16 iowrite16
                   ^
./include/asm-generic/io.h:608:20: note: in expansion of macro 'iowrite16'
 static inline void iowrite16(u16 value, volatile void __iomem *addr)
                    ^~~~~~~~~
./include/asm-generic/io.h:659:21: error: conflicting types for 'iowrite16be'
 #define iowrite16be iowrite16be
                     ^
./include/asm-generic/iomap.h:41:13: note: in expansion of macro 'iowrite16be'
 extern void iowrite16be(u16, void __iomem *);
             ^~~~~~~~~~~
./include/asm-generic/io.h:659:21: note: previous definition of 'iowrite16be' was here
 #define iowrite16be iowrite16be
                     ^
./include/asm-generic/io.h:660:20: note: in expansion of macro 'iowrite16be'
 static inline void iowrite16be(u16 value, void volatile __iomem *addr)
                    ^~~~~~~~~~~
./include/asm-generic/io.h:615:19: error: conflicting types for 'iowrite32'
 #define iowrite32 iowrite32
                   ^
./include/asm-generic/iomap.h:42:13: note: in expansion of macro 'iowrite32'
 extern void iowrite32(u32, void __iomem *);
             ^~~~~~~~~
./include/asm-generic/io.h:615:19: note: previous definition of 'iowrite32' was here
 #define iowrite32 iowrite32
                   ^
./include/asm-generic/io.h:616:20: note: in expansion of macro 'iowrite32'
 static inline void iowrite32(u32 value, volatile void __iomem *addr)
                    ^~~~~~~~~
./include/asm-generic/io.h:667:21: error: conflicting types for 'iowrite32be'
 #define iowrite32be iowrite32be
                     ^
./include/asm-generic/iomap.h:43:13: note: in expansion of macro 'iowrite32be'
 extern void iowrite32be(u32, void __iomem *);
             ^~~~~~~~~~~
./include/asm-generic/io.h:667:21: note: previous definition of 'iowrite32be' was here
 #define iowrite32be iowrite32be
                     ^
./include/asm-generic/io.h:668:20: note: in expansion of macro 'iowrite32be'
 static inline void iowrite32be(u32 value, volatile void __iomem *addr)
                    ^~~~~~~~~~~
./include/asm-generic/io.h:624:19: error: conflicting types for 'iowrite64'
 #define iowrite64 iowrite64
                   ^
./include/asm-generic/iomap.h:45:13: note: in expansion of macro 'iowrite64'
 extern void iowrite64(u64, void __iomem *);
             ^~~~~~~~~
./include/asm-generic/io.h:624:19: note: previous definition of 'iowrite64' was here
 #define iowrite64 iowrite64
                   ^
./include/asm-generic/io.h:625:20: note: in expansion of macro 'iowrite64'
 static inline void iowrite64(u64 value, volatile void __iomem *addr)
                    ^~~~~~~~~
./include/asm-generic/io.h:676:21: error: conflicting types for 'iowrite64be'
 #define iowrite64be iowrite64be
                     ^
./include/asm-generic/iomap.h:46:13: note: in expansion of macro 'iowrite64be'
 extern void iowrite64be(u64, void __iomem *);
             ^~~~~~~~~~~
./include/asm-generic/io.h:676:21: note: previous definition of 'iowrite64be' was here
 #define iowrite64be iowrite64be
                     ^
./include/asm-generic/io.h:677:20: note: in expansion of macro 'iowrite64be'
 static inline void iowrite64be(u64 value, volatile void __iomem *addr)
                    ^~~~~~~~~~~
./include/asm-generic/io.h:685:21: error: conflicting types for 'ioread8_rep'
 #define ioread8_rep ioread8_rep
                     ^
./include/asm-generic/iomap.h:60:13: note: in expansion of macro 'ioread8_rep'
 extern void ioread8_rep(void __iomem *port, void *buf, unsigned long count);
             ^~~~~~~~~~~
./include/asm-generic/io.h:685:21: note: previous definition of 'ioread8_rep' was here
 #define ioread8_rep ioread8_rep
                     ^
./include/asm-generic/io.h:686:20: note: in expansion of macro 'ioread8_rep'
 static inline void ioread8_rep(const volatile void __iomem *addr, void *buffer,
                    ^~~~~~~~~~~
./include/asm-generic/io.h:694:22: error: conflicting types for 'ioread16_rep'
 #define ioread16_rep ioread16_rep
                      ^
./include/asm-generic/iomap.h:61:13: note: in expansion of macro 'ioread16_rep'
 extern void ioread16_rep(void __iomem *port, void *buf, unsigned long count);
             ^~~~~~~~~~~~
./include/asm-generic/io.h:694:22: note: previous definition of 'ioread16_rep' was here
 #define ioread16_rep ioread16_rep
                      ^
./include/asm-generic/io.h:695:20: note: in expansion of macro 'ioread16_rep'
 static inline void ioread16_rep(const volatile void __iomem *addr,
                    ^~~~~~~~~~~~
./include/asm-generic/io.h:703:22: error: conflicting types for 'ioread32_rep'
 #define ioread32_rep ioread32_rep
                      ^
./include/asm-generic/iomap.h:62:13: note: in expansion of macro 'ioread32_rep'
 extern void ioread32_rep(void __iomem *port, void *buf, unsigned long count);
             ^~~~~~~~~~~~
./include/asm-generic/io.h:703:22: note: previous definition of 'ioread32_rep' was here
 #define ioread32_rep ioread32_rep
                      ^
./include/asm-generic/io.h:704:20: note: in expansion of macro 'ioread32_rep'
 static inline void ioread32_rep(const volatile void __iomem *addr,
                    ^~~~~~~~~~~~
./include/asm-generic/io.h:723:22: error: conflicting types for 'iowrite8_rep'
 #define iowrite8_rep iowrite8_rep
                      ^
./include/asm-generic/iomap.h:64:13: note: in expansion of macro 'iowrite8_rep'
 extern void iowrite8_rep(void __iomem *port, const void *buf, unsigned long count);
             ^~~~~~~~~~~~
./include/asm-generic/io.h:723:22: note: previous definition of 'iowrite8_rep' was here
 #define iowrite8_rep iowrite8_rep
                      ^
./include/asm-generic/io.h:724:20: note: in expansion of macro 'iowrite8_rep'
 static inline void iowrite8_rep(volatile void __iomem *addr,
                    ^~~~~~~~~~~~
./include/asm-generic/io.h:733:23: error: conflicting types for 'iowrite16_rep'
 #define iowrite16_rep iowrite16_rep
                       ^
./include/asm-generic/iomap.h:65:13: note: in expansion of macro 'iowrite16_rep'
 extern void iowrite16_rep(void __iomem *port, const void *buf, unsigned long count);
             ^~~~~~~~~~~~~
./include/asm-generic/io.h:733:23: note: previous definition of 'iowrite16_rep' was here
 #define iowrite16_rep iowrite16_rep
                       ^
./include/asm-generic/io.h:734:20: note: in expansion of macro 'iowrite16_rep'
 static inline void iowrite16_rep(volatile void __iomem *addr,
                    ^~~~~~~~~~~~~
./include/asm-generic/io.h:743:23: error: conflicting types for 'iowrite32_rep'
 #define iowrite32_rep iowrite32_rep
                       ^
./include/asm-generic/iomap.h:66:13: note: in expansion of macro 'iowrite32_rep'
 extern void iowrite32_rep(void __iomem *port, const void *buf, unsigned long count);
             ^~~~~~~~~~~~~
./include/asm-generic/io.h:743:23: note: previous definition of 'iowrite32_rep' was here
 #define iowrite32_rep iowrite32_rep
                       ^
./include/asm-generic/io.h:744:20: note: in expansion of macro 'iowrite32_rep'
 static inline void iowrite32_rep(volatile void __iomem *addr,
                    ^~~~~~~~~~~~~
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:269:0: warning: "xlate_dev_mem_ptr" redefined
 #define xlate_dev_mem_ptr(p) __va(p)
 
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:930:0: note: this is the location of the previous definition
 #define xlate_dev_mem_ptr xlate_dev_mem_ptr
 
In file included from ./include/linux/io.h:25:0,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./arch/parisc/include/asm/io.h:274:0: warning: "xlate_dev_kmem_ptr" redefined
 #define xlate_dev_kmem_ptr(p) p
 
In file included from ./arch/parisc/include/asm/io.h:262:0,
                 from ./include/linux/io.h:25,
                 from ./include/linux/irq.h:25,
                 from ./arch/parisc/include/asm/hardirq.h:13,
                 from ./include/linux/hardirq.h:9,
                 from arch/parisc/kernel/asm-offsets.c:34:
./include/asm-generic/io.h:922:0: note: this is the location of the previous definition
 #define xlate_dev_kmem_ptr xlate_dev_kmem_ptr
 
make[1]: *** [Kbuild:58: arch/parisc/kernel/asm-offsets.s] Error 1
make: *** [Makefile:1085: prepare0] Error 2
