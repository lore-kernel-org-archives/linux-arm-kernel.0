From: shankar.vk@gmail.com (Uma shankar)
Date: Fri, 4 Jun 2010 19:00:20 +0530
Subject: setting 4-Kb page-size for kernel space in ARM-Cortex
Message-ID: <AANLkTilBfY9tX1ATynkGsnVV6Bn3umx9EzvRtg66LOTa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

? ? ? ? ?It is my understanding that ?in ARM, the MMU setting for
kernel VA ?range ( 0xc0000000 onwards excluding the vmalloc and
highmem space )  is set up using the section-sized
mapping ( 1 Mb in size ) , ?as this  range maps to a ?contiguous
physical address range.

I am trying out a memory-checking tool Kmemcheck on Cortex. ? ?This tool has the
requirement that it ?needs to be able to set up ?PTE for each 4 Kb
range of ?kernel address.

So, ?paging_init ( arch/arm/mm/mmu.c ) is modified for this.

But , with this MMU setting, ? the kernel hangs somewhere ?after
freeing init memory. ( "freeing init mem" ?is the
last print I see on console. )

For ?3-level page-table setting of kernel VA, ?do I have to change
somewhere else also ?

? ? ? ? ? ? ?thanks
