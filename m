From: xiechao.maillist@gmail.com (Chao Xie)
Date: Wed, 28 Jul 2010 09:14:38 +0800
Subject: issue of kernel module with CONFIG_HIGHMEM enabled
Message-ID: <AANLkTikDuOC_dY1fMig1e0J6+D_SfWVuHYZj-_MN-B99@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hello
i am working at PXA9xx chip. It has two DDR banks, and each bank is 256MB.
In order to get more kernel virtual address, i have enabled CONFIG_HIGHMEM,
and make the second bank to be high memory. It means that i have one bank
starting virtual address from 0xC0000000 as low memory, and the second bank
is high memory.
I have compiled a module which will make use of graphics accelarate function
in PXA9XX. The module works fine when CONFIG_HIGHMEM is not enabled. I can
successfully insert the module. But when CONFIG_HIGHMEM is enabled, i fail
to insert this module, and it reports the error likes:

graphics: relocation out of range, section 2 reloc 315 sym '__kmalloc'
Module len 32542 truncated

I searched the kernel source, and find it is reported by
arch/arm/kernel/module.c. It seems that the symbols in the relocation
section can not be relocated because the section only relocate the symbols
in offset of 24 bits.
I think this issue is related to CONFIG_HIGHMEM. Can anyone help me about
the root cause of the issue and how to fix it?

Thanks.
Chao
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100728/7b6af333/attachment.html>
