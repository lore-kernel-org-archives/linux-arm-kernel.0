From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 31 Mar 2015 18:44:30 +0300
Subject: [PATCH v3 6/7] dmaengine: omap-dma: Remove mapping between virtual
 channels and requests
In-Reply-To: <20150327202230.GA4027@n2100.arm.linux.org.uk>
References: <1427459213-14611-1-git-send-email-peter.ujfalusi@ti.com>
 <1427459213-14611-7-git-send-email-peter.ujfalusi@ti.com>
 <20150327202230.GA4027@n2100.arm.linux.org.uk>
Message-ID: <551AC0DE.40807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2015 10:22 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 27, 2015 at 02:26:52PM +0200, Peter Ujfalusi wrote:
>> Do not direct map the virtual channels to sDMA request number. When the
>> sDMA is behind of a crossbar this direct mapping can cause situations when
>> certain channel can not be requested since the crossbar request number
>> will no longer match with the sDMA request line.
>> The direct mapping for virtual channels with HW request lines will make it
>> harder to implement MEM_TO_MEM mode for the driver.
> 
> There's no point having 127 virtual DMA channels then... is there?
> We might as well reduce the number down to a more reasonable set
> rather than wasting memory.

I was also come to the same conclusion. My plan was to change the virtual DMA
channels to the same as the sDMA's logical channels.

>> @@ -1049,7 +1050,6 @@ static int omap_dma_chan_init(struct omap_dmadev *od, int dma_sig)
>>  		return -ENOMEM;
>>  
>>  	c->reg_map = od->reg_map;
>> -	c->dma_sig = dma_sig;
> 
> That's the only user of dma_sig in this function.  Why not remove it from
> the function prototype and its caller?
> 


-- 
P?ter
