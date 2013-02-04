From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Feb 2013 15:11:32 +0000
Subject: [PATCHv2 1/2] ARM: dma-mapping: add support for CMA regions
 placed in highmem zone
In-Reply-To: <xa1ta9rkb0od.fsf@mina86.com>
References: <1358350284-6972-2-git-send-email-m.szyprowski@samsung.com>
 <1359984182-6307-1-git-send-email-m.szyprowski@samsung.com>
 <xa1tlib4b30n.fsf@mina86.com> <20130204141053.GD17786@n2100.arm.linux.org.uk>
 <xa1tfw1cb1ho.fsf@mina86.com> <20130204143433.GE17786@n2100.arm.linux.org.uk>
 <xa1ta9rkb0od.fsf@mina86.com>
Message-ID: <20130204151132.GF17786@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 03:42:26PM +0100, Michal Nazarewicz wrote:
> > On Mon, Feb 04, 2013 at 03:24:51PM +0100, Michal Nazarewicz wrote:
> >> Perhaps it should use lowmem_page_address() then?
> 
> On Mon, Feb 04 2013, Russell King - ARM Linux wrote:
> > It's well defined that page_address() will be non-NULL for lowmem pages.
> > There is nothing wrong with the above.
> 
> It would save on a branch and a function call though.

Depending on the size of struct page, if we care that much, we can probably
enable WANT_PAGE_VIRTUAL which'll make it even cheaper as it's just a
dereference.
