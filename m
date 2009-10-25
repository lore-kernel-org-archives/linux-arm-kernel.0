From: zyxsjl@126.com (zyxsjl)
Date: Sun, 25 Oct 2009 14:49:48 +0800 (CST)
Subject: abt kernel 2.6 compressed/head.s
Message-ID: <7866344.98541256453388015.JavaMail.coremail@bj126app34.126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi anyone, I have not understood some code in this file below: #ifndef CONFIG_ZBOOT_ROM /* * If we're running fully PIC === CONFIG_ZBOOT_ROM = n, * we need to fix up pointers into the BSS region. * r2 - BSS start * r3 - BSS end * sp - stack pointer */ add r2, r2, r0 add r3, r3, r0 add sp, sp, r0 /* * Relocate all entries in the GOT table. */ 1: ldr r1, [r6, #0] @ relocate entries in the GOT add r1, r1, r0 @ table. This fixes up the str r1, [r6], #4 @ C references. cmp r6, ip blo 1b #else /* * Relocate entries in the GOT table. We only relocate * the entries that are outside the (relocated) BSS region. */ 1: ldr r1, [r6, #0] @ relocate entries in the GOT cmp r1, r2 @ entry 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091025/b0453206/attachment-0001.htm>
