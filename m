From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 28 Feb 2014 09:24:27 -0500
Subject: [PATCH] dma: of: Move the functions under CONFIG_OF_DMA instead
 of CONFIG_OF
In-Reply-To: <6287295.Q1WPJPjeZV@wuerfel>
References: <1393546850-13907-1-git-send-email-santosh.shilimkar@ti.com>
 <530FD7D7.9000104@ti.com> <6287295.Q1WPJPjeZV@wuerfel>
Message-ID: <53109C1B.2030606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 February 2014 04:23 AM, Arnd Bergmann wrote:
> On Thursday 27 February 2014 19:27:03 Santosh Shilimkar wrote:
>>
>> The of-dma.c is compiled out with !CONFIG_DMA_OF but the functions in
>> the header are kept under CONFIG_OF. Move them under CONFIG_OF_DMA
>> to avoid build errors with CONFIG_OFF && !CONFIG_DMA_OF
>>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Sorry, but what is the problem you are seeing with this?
> 
> CONFIG_DMA_OF is defined as 'OF && DMAENGINE', and this code
> should only be called from drivers that depend on DMAENGINE.
> 
> I'm not saying your patch is wrong, but you shouldn't need it
> unless you do something very odd.
> 
So for ARM 'allnoconfig' build we have CONFIG_OF enabled but
CONFIG_DMA_OF disabled. With that the of-dma.c gets compiled
out leaving the functions from of-dma.h undefined. I noticed
this while adding couple of exports in of_dma.h

I am not sure but we added couple of functions for dma-ranges
and dma-coherent which gets called from generic code.

In any case, the patch makes sense since the header and Makefile
are not consistent.

Regards,
Santosh
