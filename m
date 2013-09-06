From: thommyj@gmail.com (Thommy Jakobsson)
Date: Fri, 6 Sep 2013 11:04:40 +0200 (CEST)
Subject: kmalloc memory slower than malloc
In-Reply-To: <20130906080705.GN6617@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
 <20130906080705.GN6617@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1309061051440.1299@kelly.ryd.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 6 Sep 2013, Russell King - ARM Linux wrote:

> Your driver appears to be exposing physical addresses to userspace.
> This is a no-go.  This is a massive security hole - it allows userspace
> to map any physical address and write into that memory.  That includes
> system flash and all system RAM.
Sorry Russell, maybe I was unclear, the attached test was just a quick 
hack to be able to compare kmalloc and dma_coherent_alloc with malloc. This is not 
code that is part of the actual driver.

> This gives userspace a way to overwrite the kernel with exploits,
> retrieve sensitive and/or personal data, etc.
> 
> Therefore, I will not provide any assistance with this.  Please change
> your approach so you do not need physical addresses in userspace.
I see your point, but as I said I do not do that in my driver. I do map 
in the dmabuffer in userspace though, so I expose a virtual mapping to 
userspace. I have understand that to be a "normal" approach for speeding 
things up, or do you consider that to be wrong as well?

thanks,
Thommy
