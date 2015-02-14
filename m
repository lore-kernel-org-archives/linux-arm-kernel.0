From: ali.soleimani.dehdivan@gmail.com (ali soleimanidehdivan)
Date: Sat, 14 Feb 2015 12:10:30 -0500
Subject: mmap cached memory mapped io in user space
Message-ID: <CAGnjDtwRFoYtk_Jxy66nQRz7dYA550Rx5BgzPtPMJhD_EZeQkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i need to cache data for sending to memory mapped io device because
device is using axi full protocol. i write data to cache and then
flush it so data is written using burst mode

i did some research and finnally i add this lines

#define pgprot_devcached(prot) \
    __pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_DEV_CACHED)

to arch/arm/include/asm/pgtable.h.

but this doesn't work good actually it works for just first burst. if
your data is bigger than a burst it doesn't work and just send first
burst. how can i use cache for data bigger than a burst. i done it in
standalone os from xilinx but i stuck on it in linux. my platform is
zynq.

p.s: i know i can use ioremap_cache but i want to full buffer from
user space and performance is critical in this situation.
