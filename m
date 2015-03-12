From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 12 Mar 2015 14:55:54 +0100
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid
 crash on armada-xp
In-Reply-To: <55018E8B.8060704@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150311175227.499612af@free-electrons.com>
 <55007ADD.6080505@list.ru>
 <20150311174618.GE8656@n2100.arm.linux.org.uk>
 <55008483.8050603@list.ru>
 <20150311193343.0317e3e1@free-electrons.com>
 <55018A3C.7020409@list.ru>
 <20150312134756.5335cb32@free-electrons.com>
 <55018E8B.8060704@list.ru>
Message-ID: <20150312145554.72a6b09d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stas Sergeev,

On Thu, 12 Mar 2015 16:03:07 +0300, Stas Sergeev wrote:

> > No, this is expected. Your physical address space is shared between RAM
> > and I/O devices. So the space 0xf0000000 -> 0xffffffff in the physical
> > address space is where all the registers for your SoC and PCIe devices
> Yeah, I realize that, but I was hoping that some work-around
> exists. For example, move entire dimm above 4G? Is this really
> impossible? Or maybe move overlapping region above 8G...

I am not aware of any trick that would allow to do that, but I have
also never looked in the deep details of the Marvell memory controller
and what's possible to do with it.

Moving entire DIMM above 4G is clearly not possible: devices can only
do DMA on the first 32 bits of the physical address space. So if you
move all the physical memory above 4G, you don't have any memory left
for DMA.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
