From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Nov 2010 13:49:13 +0000
Subject: Size of dma_alloc_writecombine.
In-Reply-To: <AANLkTi=287gpR8eeQH-p5ZHEW5GtFQoqHa-TA_-NW1ZN@mail.gmail.com>
References: <AANLkTi=287gpR8eeQH-p5ZHEW5GtFQoqHa-TA_-NW1ZN@mail.gmail.com>
Message-ID: <20101110134913.GB24305@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 10, 2010 at 02:35:09PM +0530, vipul samar wrote:
> Hello,
> 
> I am working on LCD module of resolution size 1024X768. When i am allocating
> memory for frame buffer using dma_alloc_writecombine call its not able to
> allocate memory more then 2MB memory. The Reason is the maximum size
> allocated by  dma_alloc_writecombine is 2 MB.

In your mach/memory.h, define CONSISTENT_DMA_SIZE to be a multiple of 2MB.
This sets the size of the DMA area.
