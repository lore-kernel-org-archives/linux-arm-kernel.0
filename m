From: lkp@intel.com (kbuild test robot)
Date: Wed, 7 Oct 2015 04:51:56 +0800
Subject: [PATCH] genirq: export handle_bad_irq
In-Reply-To: <5847725.4IBopItaOr@wuerfel>
Message-ID: <201510070422.sqnilsXm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test WARNING on v4.3-rc4 -- if it's inappropriate base, please ignore]

reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   kernel/irq/handle.c:31: warning: Excess function parameter 'irq' description in 'handle_bad_irq'
>> kernel/irq/handle.c:1: warning: no structured comments found

vim +1 kernel/irq/handle.c

^1da177e Linus Torvalds     2005-04-16  @1  /*
^1da177e Linus Torvalds     2005-04-16   2   * linux/kernel/irq/handle.c
^1da177e Linus Torvalds     2005-04-16   3   *
a34db9b2 Ingo Molnar        2006-06-29   4   * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
a34db9b2 Ingo Molnar        2006-06-29   5   * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
^1da177e Linus Torvalds     2005-04-16   6   *
^1da177e Linus Torvalds     2005-04-16   7   * This file contains the core interrupt handling code.
a34db9b2 Ingo Molnar        2006-06-29   8   *
a34db9b2 Ingo Molnar        2006-06-29   9   * Detailed information is available in Documentation/DocBook/genericirq
a34db9b2 Ingo Molnar        2006-06-29  10   *
^1da177e Linus Torvalds     2005-04-16  11   */
^1da177e Linus Torvalds     2005-04-16  12  
^1da177e Linus Torvalds     2005-04-16  13  #include <linux/irq.h>
^1da177e Linus Torvalds     2005-04-16  14  #include <linux/random.h>
3795de23 Thomas Gleixner    2010-09-22  15  #include <linux/sched.h>
^1da177e Linus Torvalds     2005-04-16  16  #include <linux/interrupt.h>
^1da177e Linus Torvalds     2005-04-16  17  #include <linux/kernel_stat.h>
3795de23 Thomas Gleixner    2010-09-22  18  
ad8d75ff Steven Rostedt     2009-04-14  19  #include <trace/events/irq.h>
^1da177e Linus Torvalds     2005-04-16  20  
^1da177e Linus Torvalds     2005-04-16  21  #include "internals.h"
^1da177e Linus Torvalds     2005-04-16  22  
6a6de9ef Thomas Gleixner    2006-06-29  23  /**
6a6de9ef Thomas Gleixner    2006-06-29  24   * handle_bad_irq - handle spurious and unhandled irqs
43a1dd50 Henrik Kretzschmar 2006-08-31  25   * @irq:       the interrupt number
43a1dd50 Henrik Kretzschmar 2006-08-31  26   * @desc:      description of the interrupt
43a1dd50 Henrik Kretzschmar 2006-08-31  27   *
43a1dd50 Henrik Kretzschmar 2006-08-31  28   * Handles spurious and unhandled IRQ's. It also prints a debugmessage.
6a6de9ef Thomas Gleixner    2006-06-29  29   */
bd0b9ac4 Thomas Gleixner    2015-09-14  30  void handle_bad_irq(struct irq_desc *desc)
6a6de9ef Thomas Gleixner    2006-06-29 @31  {
bd0b9ac4 Thomas Gleixner    2015-09-14  32  	unsigned int irq = irq_desc_get_irq(desc);
bd0b9ac4 Thomas Gleixner    2015-09-14  33  
43f77759 Ingo Molnar        2006-06-29  34  	print_irq_desc(irq, desc);

:::::: The code at line 1 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 6062 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/191d3d36/attachment.obj>
