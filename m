From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 16 Dec 2010 12:49:43 +0100
Subject: OMAP3: Warning: swp{b} use is deprecated for this architecture
Message-ID: <AANLkTinmg4SyQNz5ide40YYC7k_MRQ6Q-j=WKN7jLC68@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following warning is issued by the compiler (gcc version 4.4.1
(Sourcery G++ Lite 2010q1-202):
arch/arm/mach-omap2/sleep34xx.S:87: Warning: swp{b} use is deprecated
for this architecture

Does this need fixing? If so any hint on how to do it?

Here is the offending code excerpt:

wait_sem:
        mov     r0,#1
        ldr     r1, sdrc_scratchpad_sem
wait_loop:
        ldr     r2, [r1]        @ load the lock value
        cmp     r2, r0          @ is the lock free ?
        beq     wait_loop       @ not free...
        swp     r2, r0, [r1]    @ semaphore free so lock it and proceed
        cmp     r2, r0          @ did we succeed ?
        beq     wait_sem        @ no - try again

Regards,
Jean
