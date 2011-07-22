From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jul 2011 14:55:05 +0100
Subject: at91sam9g45: Issues while working with RAM that is separated
	on physical address space
In-Reply-To: <CAA2DH4u1kcky3xzxpepS=gtDK1Xas17zDxcRkDR7qRNLHQyoxw@mail.gmail.com>
References: <CAA2DH4u1kcky3xzxpepS=gtDK1Xas17zDxcRkDR7qRNLHQyoxw@mail.gmail.com>
Message-ID: <20110722135505.GB25947@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 07:06:40PM +0530, P J wrote:
> The memory map (required) is as follows:
>     phys           =>          virt
> 0x70000000    =>    0xC0000000  (128 MB)
> 0x20000000    =>    0xC8000000  (128 MB)

There is no way that the kernel will support this kind of hair-brained
memory layout.  This is even more true than it once was since we've moved
to using memblock to manage the physical memory layout in later kernels.

What the kernel will support is using 0x20000000 as the first bank and
0x70000000 as the second bank of memory.  I suggest trying with it mapped
that way around, and failing that then using highmem support without
sparse.
