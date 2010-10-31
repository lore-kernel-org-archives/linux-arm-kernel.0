From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 31 Oct 2010 18:31:40 +0000
Subject: ep93xx/ts72xx: Kernel 2.6.36 problems introduced with commit
	5bc23d32d
In-Reply-To: <20101031182157.GY15069@ibawizard.net>
References: <20101031182157.GY15069@ibawizard.net>
Message-ID: <20101031183140.GA30636@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 31, 2010 at 07:21:57PM +0100, Petr ?tetiar wrote:
> The allocation of the 4th buffer fails here and goes to nospc label. When I've
> reverted commit mentioned in the subject:
> 
>     Revert "ARM: DMA coherent allocator: align remapped addresses"
>     
>     This reverts commit 5bc23d32d86a132b5636a48dca0fa2528ef69ff9.
> 
> the driver can now allocate the buffers and seems to work on 2.6.36. How to
> proceed now? I know, that the driver is pile of crap, but it works for me(tm)
> quite well on 2.6.34.7, so I don't know how to fix this. Thank you for any
> suggestions.

It might be worth adding a printk to find out what entries get allocated
and freed from the vmregion.
