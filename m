From: dhylands@gmail.com (Dave Hylands)
Date: Sun, 16 Jan 2011 10:39:15 -0800
Subject: about arm_add_memory
In-Reply-To: <7ce5e8c1.b773.12d757289fc.Coremail.wj_nwpu@163.com>
References: <7ce5e8c1.b773.12d757289fc.Coremail.wj_nwpu@163.com>
Message-ID: <AANLkTi=6EJurjpmgHHY938UScgVwQLTNLDiDuDzpS27W@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2011/1/11 wangjun <wj_nwpu@163.com>:
> in? /arch/arm/kernel/setup.c
>
> static int __init arm_add_memory(unsigned long start, unsigned long size)
> ...
> size -= start & ~PAGE_MASK;
> bank->start = PAGE_ALIGN(start);
> bank->size ?= size & PAGE_MASK;
> bank->node ?= PHYS_TO_NID(start);
> .....
>
> what?? size -= start & ~PAGE_MASK? to do ?

If you passed in a non-aligned start address, then this adjusts the
size by the same amount as bank->start = PAGE_ALIGN(start) will adjust
the start address.

Dave Hylands
