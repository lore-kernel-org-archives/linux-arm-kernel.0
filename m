From: qiyaoltc@gmail.com (Yao Qi)
Date: Wed, 17 May 2017 17:04:26 +0100
Subject: Unwinding stop on irq handler or across it?
Message-ID: <86o9ur8o6t.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
When use GDB debug Linux kernel, GDB can't stop on unwinding from an irq
handler,

#0  gic_handle_irq (regs=0xffffffc07d9c7e30) at drivers/irqchip/irq-gic.c:263
#1  0xffffffc000083ce4 in el1_irq () at arch/arm64/kernel/entry.S:346
#2  0xffffffc000083ce4 in el1_irq () at arch/arm64/kernel/entry.S:346
#3  0xffffffc000083ce4 in el1_irq () at arch/arm64/kernel/entry.S:346
....

This problem can be fixed by either adding .cfi directives in entry.S
or adding some Linux awareness into GDB.  I want to know what is the
expected behavior?  Is it reasonable that stack unwinding stops on irq
handler, like el1_irq in this case? or something else?

-- 
Yao (??)
