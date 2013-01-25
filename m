From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jan 2013 09:50:45 -0800
Subject: [PATCH 3/5] ARM: samsung: fix assembly syntax for new gas
In-Reply-To: <1359127711-19070-4-git-send-email-arnd@arndb.de>
References: <1359127711-19070-1-git-send-email-arnd@arndb.de>
 <1359127711-19070-4-git-send-email-arnd@arndb.de>
Message-ID: <00fb01cdfb24$81fbce10$85f36a30$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> Recent assembler versions complain about extraneous
> whitespace inside [] brackets. This fixes all of
> these instances for the samsung platforms. We should
> backport this to all kernels that might need to
> be built with new binutils.
> 
> arch/arm/kernel/entry-armv.S: Assembler messages:
> arch/arm/kernel/entry-armv.S:214: Error: ARM register expected -- `ldr
> r2,[ r6,#(0x10)]'
> arch/arm/kernel/entry-armv.S:214: Error: ARM register expected -- `ldr
> r0,[ r6,#(0x14)]'
> arch/arm/kernel/entry-armv.S:430: Error: ARM register expected -- `ldr
> r2,[ r6,#(0x10)]'
> arch/arm/kernel/entry-armv.S:430: Error: ARM register expected -- `ldr
> r0,[ r6,#(0x14)]'
> arch/arm/mach-s3c24xx/sleep-s3c2410.S: Assembler messages:
> arch/arm/mach-s3c24xx/sleep-s3c2410.S:48: Error: ARM register expected --
> `ldr r7,[ r4 ]'
> arch/arm/mach-s3c24xx/sleep-s3c2410.S:49: Error: ARM register expected --
> `ldr r8,[ r5 ]'
> arch/arm/mach-s3c24xx/sleep-s3c2410.S:50: Error: ARM register expected --
> `ldr r9,[ r6 ]'
> arch/arm/mach-s3c24xx/sleep-s3c2410.S:64: Error: ARM register expected --
> `streq r7,[ r4 ]'
> arch/arm/mach-s3c24xx/sleep-s3c2410.S:65: Error: ARM register expected --
> `streq r8,[ r5 ]'
> arch/arm/mach-s3c24xx/sleep-s3c2410.S:66: Error: ARM register expected --
> `streq r9,[ r6 ]'
> arch/arm/kernel/debug.S: Assembler messages:
> arch/arm/kernel/debug.S:83: Error: ARM register expected -- `ldr
> r2,[ r2,#((0x0B0)+(((0x56000000)-
> (0x50000000))+(0xF6000000+(0x01000000))))-((0)+(((0x56000000)-
> (0x50000000))+(0xF6000000+(0x01000000))))]'
> arch/arm/kernel/debug.S:83: Error: ARM register expected -- `ldr
> r2,[ r3,#(0x18)]'
> arch/arm/kernel/debug.S:85: Error: ARM register expected -- `ldr
> r2,[ r2,#((0x0B0)+(((0x56000000)-
> (0x50000000))+(0xF6000000+(0x01000000))))-((0)+(((0x56000000)-
> (0x50000000))+(0xF6000000+(0x01000000))))]'
> arch/arm/kernel/debug.S:85: Error: ARM register expected -- `ldr
> r2,[ r3,#(0x18)]'
> arch/arm/mach-s3c24xx/pm-h1940.S: Assembler messages:
> arch/arm/mach-s3c24xx/pm-h1940.S:33: Error: ARM register expected -- `ldr
> pc,[ r0,#((0x0B8)+(((0x56000000)-
> (0x50000000))+(0xF6000000+(0x01000000))))-(((0x56000000)-
> (0x50000000))+(0xF6000000+(0x01000000)))]'
> arch/arm/mach-s3c24xx/sleep-s3c2412.S: Assembler messages:
> arch/arm/mach-s3c24xx/sleep-s3c2412.S:60: Error: ARM register expected --
> `ldrne r9,[ r1 ]'
> arch/arm/mach-s3c24xx/sleep-s3c2412.S:61: Error: ARM register expected --
> `strne r9,[ r1 ]'
> arch/arm/mach-s3c24xx/sleep-s3c2412.S:62: Error: ARM register expected --
> `ldrne r9,[ r2 ]'
> arch/arm/mach-s3c24xx/sleep-s3c2412.S:63: Error: ARM register expected --
> `strne r9,[ r2 ]'
> arch/arm/mach-s3c24xx/sleep-s3c2412.S:64: Error: ARM register expected --
> `ldrne r9,[ r3 ]'
> arch/arm/mach-s3c24xx/sleep-s3c2412.S:65: Error: ARM register expected --
> `strne r9,[ r3 ]'
> arch/arm/kernel/debug.S:83: Error: ARM register expected -- `ldr
> r2,[ r3,#(0x08)]'
> arch/arm/kernel/debug.S:83: Error: ARM register expected -- `ldr
> r2,[ r3,#(0x18)]'
> arch/arm/kernel/debug.S:83: Error: ARM register expected -- `ldr
> r2,[ r3,#(0x10)]'
> arch/arm/kernel/debug.S:85: Error: ARM register expected -- `ldr
> r2,[ r3,#(0x08)]'
> arch/arm/kernel/debug.S:85: Error: ARM register expected -- `ldr
> r2,[ r3,#(0x18)]'
> arch/arm/kernel/debug.S:85: Error: ARM register expected -- `ldr
> r2,[ r3,#(0x10)]'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

[...]

Thanks.

- Kukjin
