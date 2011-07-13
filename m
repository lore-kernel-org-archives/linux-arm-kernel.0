From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 14 Jul 2011 04:35:28 +0530
Subject: [PATCH 0/9] PL08x further cleanups
In-Reply-To: <20110705131030.GE8286@n2100.arm.linux.org.uk>
References: <20110705131030.GE8286@n2100.arm.linux.org.uk>
Message-ID: <1310598328.1536.27.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-07-05 at 14:10 +0100, Russell King - ARM Linux wrote:
> This patch series is the remainder of the PL08x work I did earlier
> this year while trying to get the ARM platforms working with DMA.
> 
> Unfortunately, due to the state of the hardware, I was not able to
> properly test these changes.  However, they do compile, and I think
> if others are going to be looking at the PL08x DMA engine driver,
> they're worth having.
> 
> Linus, can you check these out on your hardware please?

Russell,

The fail to build for me, on line 550 it refers to bd.llil_bus whereas
the bd is a pointer. Further the WIDTH macros seem to be missing.

While you are fixing this, you may want to fix the minor checkpatch
warning as well.

drivers/dma/amba-pl08x.c: In function 'pl08x_fill_lli_for_desc':
drivers/dma/amba-pl08x.c:550: error: request for member 'lli_bus' in
something not a structure or union
drivers/dma/amba-pl08x.c: In function 'pl08x_width':
drivers/dma/amba-pl08x.c:1121: error: 'PL08X_WIDTH_8BIT' undeclared
(first use in this function)
drivers/dma/amba-pl08x.c:1121: error: (Each undeclared identifier is
reported only once
drivers/dma/amba-pl08x.c:1121: error: for each function it appears in.)
drivers/dma/amba-pl08x.c:1123: error: 'PL08X_WIDTH_16BIT' undeclared
(first use in this function)
drivers/dma/amba-pl08x.c:1125: error: 'PL08X_WIDTH_32BIT' undeclared
(first use in this function)
drivers/dma/amba-pl08x.c:1119: warning: enumeration value
'DMA_SLAVE_BUSWIDTH_UNDEFINED' not handled in switch
drivers/dma/amba-pl08x.c:1119: warning: enumeration value
'DMA_SLAVE_BUSWIDTH_8_BYTES' not handled in switch
make[1]: *** [drivers/dma/amba-pl08x.o] Error 1


-- 
~Vinod
