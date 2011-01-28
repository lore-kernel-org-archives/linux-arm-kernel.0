From: ierton@gmail.com (Sergey Mironov)
Date: Fri, 28 Jan 2011 17:28:29 +0300
Subject: RAM bank with features
Message-ID: <AANLkTimDFdP7O3h9Zrx2gacqaBS=8TVfpeZP5cFX+T2e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, community. I am porting Linux to arm1176-based SoC. Our system
has 2 RAM banks. First one (EM0) is quite common, but another (EM1)
has some "features" :
1) Critical one. There are devices that can't use DMA buffers outside EM1.
2) CPU can read and write to it, but can't execute instructions.

What is the finest way of implementing those restrictions? I thought
about defining custom memory zone, but I can't see how to link zones
with platform_device.dev.dma_mask.

Also, is it possible to allocate user pages from EM1 but prevent users
from executing code from them? Say, tell allocator to mark them with
L_PTE_* flag?

Thanks,
Sergey.
