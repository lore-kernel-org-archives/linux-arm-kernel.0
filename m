From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Sep 2009 21:26:05 +0100
Subject: Kernel bug or hardware problem
In-Reply-To: <58554.72.76.4.145.1251234312.squirrel@webmail.hostgator.com>
References: <58554.72.76.4.145.1251234312.squirrel@webmail.hostgator.com>
Message-ID: <20090918202605.GI6601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2009 at 04:05:12PM -0500, zql at glomationinc.com wrote:
> Atmel 9G20 based custom board with 32MB SDRAM.  Experiencing "random"
> segmentation faults.  The following is an example,
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c1edc000
> [00000000] *pgd=21ddc031, *pte=00000000, *ppte=00000000
> Internal error: Oops: 817 [#1]
> Modules linked in:
> CPU: 0    Not tainted  (2.6.27.4 #4)
> PC is at __bug+0x20/0x2c

This is a BUG(), but it seems that you've disabled verbose bug reporting.
It'd be useful to have it enabled.  There's several BUG()s in
cache_alloc_refill, so no idea which.

Also, I think you should report this on lkml; I'm sure there are people
more experienced with the slab allocator who might be able to comment on
this.
