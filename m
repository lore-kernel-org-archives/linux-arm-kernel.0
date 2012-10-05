From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Oct 2012 09:45:00 +0100
Subject: [PATCH] [ARM] Use AT() in the linker script to create correct
 program headers
In-Reply-To: <20121001160639.GA31620@obsidianresearch.com>
References: <20120930232116.GC30637@obsidianresearch.com>
 <20121001153952.GB2100@linaro.org>
 <20121001160639.GA31620@obsidianresearch.com>
Message-ID: <20121005084500.GI4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 10:06:39AM -0600, Jason Gunthorpe wrote:
> On Mon, Oct 01, 2012 at 04:39:53PM +0100, Dave Martin wrote:
> > >   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
> > >   LOAD           0x008000 0xc0008000 0x00008000 0x372244 0x3a4310 RWE 0x8000
> > 
> > Not related directly to your patch, but I wonder why we don't we see
> > separate r-x and rw- segments?
> 
> I think this is because the sections are not aligned when the
> protections change, and the sections are not sorted by protection
> type.

They aren't sorted by protection type, they're ordered according to what's
required for the kernel - which is to have the init sections together as
one complete block so that it can be freed, and to place all of the kernel
text as close to the beginning of the image as possible.
