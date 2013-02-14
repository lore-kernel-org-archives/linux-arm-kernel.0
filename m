From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Feb 2013 22:30:13 +0100
Subject: [PATCH 0/2] Device Tree support for CMA (Contiguous Memory
 Allocator)
In-Reply-To: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
References: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20130214213013.GG1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Thu, Feb 14, 2013 at 01:45:26PM +0100, Marek Szyprowski wrote:
> Hello,
> 
> Here is my initial proposal for device tree integration for Contiguous
> Memory Allocator. The code is quite straightforward, however I expect
> that the memory bindings require some discussion.
> 
> The proposed bindings allows to define contiguous memory regions of
> specified base address and size. Then, the defined regions can be
> assigned to the given device(s) by adding a property with a phanle to
> the defined contiguous memory region. From the device tree perspective
> that's all. Once the bindings are added, all the memory allocations from
> dma-mapping subsystem will be served from the defined contiguous memory
> regions.
> 

I think CMA regions should not be described in the devicetre at all. The
devicetree is about hardware description and it should be OS agnostic,
but CMA is only a Linux specific implementation detail. It's not even
specific to a particular board, it's specific to a particular usecase of
a board.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
