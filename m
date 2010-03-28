From: leo.barnes@algotrim.com (Leo Barnes)
Date: Sun, 28 Mar 2010 19:51:38 +0200
Subject: Enabling D-cache for OneNAND BufferRAM
Message-ID: <4BAF972A.5080102@algotrim.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

I am writing a piece of software that will utilize the fact that OneNAND 
bufferram can do execute-in-place (or in my case, decode-in-place). I am 
however getting quite bad results since the D-cache is not enabled for 
the bufferram (for good reason since it is device memory). Since I have 
exclusive control over the OneNAND chip, I know exactly what information 
is in the bufferram at all times, and should therefore be able to enable 
the cache for it as long as I invalidate it when performing loads.

My question is:
How do I enable the cache for the bufferram? I assume that I will 
somehow have to change the memory attributes in the memory map for that 
part of physical memory. The people over at linux-mtd suggested using 
ioremap_cached which supposedly creates a second mapping to the physical 
address in question. From what I recall of the ARM documentation, I 
thought this was illegal since there may not be two maps of the same 
physical address with differing memory attributes. Am I wrong?

The kernel documentation also mentions that if ioremap_cached is used, 
the virtual address returned should only be accessed by readl() and 
similar. Is this necessary? My code is written in assembler since it 
requires extreme optimization, and a lot of the reads there have to be 
performed using ldrb (which is why I would like the cache to be 
enabled). Is it possible to remap the bufferram with cacheing enabled 
while still being able to access it with ldrb?

Hope someone can help!
Best regards,
//Leo
