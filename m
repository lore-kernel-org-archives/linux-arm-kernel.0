From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 8 Feb 2013 09:23:24 -0600
Subject: [PATCH 2/2] dmaengine: OMAP: Register SDMA controller with Device
 Tree DMA driver
In-Reply-To: <201302071439.13720.arnd@arndb.de>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
 <1360184596-1603-3-git-send-email-jon-hunter@ti.com>
 <201302071439.13720.arnd@arndb.de>
Message-ID: <5115186C.2070406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/07/2013 08:39 AM, Arnd Bergmann wrote:
> On Wednesday 06 February 2013, Jon Hunter wrote:
>> +static struct of_dma_filter_info info;
> 
> Both members of this structure are constant, so you can just initialize it here,
> and it would be nice to give it a more descriptive name, such as omap_dmadev_info.

No problem. By the way, I see the dma_cap_mask_t is defined as follows ...

typedef struct { DECLARE_BITMAP(bits, DMA_TX_TYPE_END); } dma_cap_mask_t;

Is there a good way to statically initialise this?

Cheers
Jon
