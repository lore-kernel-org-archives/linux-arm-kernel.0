From: venkats.goli@gmail.com (Venkateswar Rao Goli)
Date: Wed, 16 Jul 2014 17:51:16 +0100
Subject: Regarding module size change in ARM kernel
Message-ID: <CAKuQT6xdcsQM6a4PXO40SvbqSdccJ7bkS6Arz0yqU9RRpcoVQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,

I'm running out of module size memory i.e, 14MB  ( CONFIG_HIGHMEM is
enabled in config ) . I've tried to increase by changing as below,
could you please let us know if it would cause any regressions in any
of the application or scenario ?

linux-3.8.13-2.2/arch/arm/include/asm/memory.h  ?

NEW:
#define TASK_SIZE               (UL(CONFIG_PAGE_OFFSET) - 18*1024*1024)
#define MODULES_VADDR           (PAGE_OFFSET - 18*1024*1024)

OLD:
#define TASK_SIZE               (UL(CONFIG_PAGE_OFFSET) - UL(SZ_16M))
#define MODULES_VADDR           (PAGE_OFFSET - 16*1024*1024)


kernel version     :   3.8.13-2.2 #3 SMP
CPU model name      :    ARMv7 Processor rev 2 (v7l)


Regards,
Venkat Goli
