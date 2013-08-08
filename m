From: xvzhaobin@gmail.com (zhaobin xv)
Date: Thu, 8 Aug 2013 10:08:02 +0800
Subject: __ARM_ARCH_2__
Message-ID: <CANEcUBWAYe1Zkes3ZxFr9Copwh-H9Meijg6eupiQaKRUR0Jmdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

In linux/arch/arm/boot/compressed/head.S:


#ifndef __ARM_ARCH_2__
        /*
         * Booting from Angel - need to enter SVC mode and disable
         * FIQs/IRQs (numeric definitions from angel arm.h source).
         * We only do this if we were in user mode on entry.
         */
        mrs    r2, cpsr        @ get current mode
        tst    r2, #3            @ not user?
        bne    not_angel
        mov    r0, #0x17        @ angel_SWIreason_EnterSVC
        swi    0x123456        @ angel_SWI_ARM


I don't know what the"__ARM_ARCH_2__" mean?
"__ARM_ARCH_2__" is definded by gcc or definded byarmlinux?
where does it come from? what does it want to do?
