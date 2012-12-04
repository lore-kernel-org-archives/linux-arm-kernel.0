From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 4 Dec 2012 18:18:54 +0100
Subject: [PATCH] net/macb: Use dmapool to align descriptors on 64bits
In-Reply-To: <1354543290.7030.26.camel@deadeye.wl.decadent.org.uk>
References: <1354536914-6315-1-git-send-email-nicolas.ferre@atmel.com>
 <1354543290.7030.26.camel@deadeye.wl.decadent.org.uk>
Message-ID: <50BE307E.9090904@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2012 03:01 PM, Ben Hutchings :
> On Mon, 2012-12-03 at 13:15 +0100, Nicolas Ferre wrote:
>> Depending on datapath, some revisions of GEM need
>> 64bits aligned descriptors. Use dmapool to allocate
>> these descriptors.
>> Note that different size between RX and TX rings
>> leads to the creation of two pools.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> [...]
> 
> dma_alloc_coherent() allocates whole pages, which I think is quite
> enough alignment.  You can't save memory by doing this, since each pool
> needs at least one page.  So what is this change meant to achieve?

Well... I guess we can forget this patch then ;-)

Thanks, best regards,
-- 
Nicolas Ferre
