From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 3 Dec 2015 17:46:18 +0200
Subject: [PATCH 4/4] dmaengine: edma: Add support for DMA filter mapping
 to slave devices
In-Reply-To: <2675730.x1sS4Fa4y8@wuerfel>
References: <1449153192-9082-1-git-send-email-peter.ujfalusi@ti.com>
 <1449153192-9082-5-git-send-email-peter.ujfalusi@ti.com>
 <2675730.x1sS4Fa4y8@wuerfel>
Message-ID: <566063CA.20500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2015 05:38 PM, Arnd Bergmann wrote:
> On Thursday 03 December 2015 16:33:12 Peter Ujfalusi wrote:
>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>> index 0675e268d577..46b305ea0d21 100644
>> --- a/drivers/dma/edma.c
>> +++ b/drivers/dma/edma.c
>> @@ -2297,6 +2297,12 @@ static int edma_probe(struct platform_device *pdev)
>>                 edma_set_chmap(&ecc->slave_chans[i], ecc->dummy_slot);
>>         }
>>  
>> +       if (info->slave_map) {
>> +               ecc->dma_slave.filter_map.map = info->slave_map;
>> +               ecc->dma_slave.filter_map.mapcnt = info->slavecnt;
>> +               ecc->dma_slave.filter_map.filter_fn = edma_filter_fn;
>> +       }
>> +
>>
> 
> Just a minor comment here: I think all three assignments can be done
> unconditionally.

True.

> As I mentioned before, I'd also remove 'struct dma_filter'
> and put the three members in struct dma_device directly. In fact, the
> filter function can go with the other function pointers for consistency.

I just like to keep things in one place ;)
I don't have strong stand on keeping the intermediate 'struct dma_filter'
Let's hear from Vinod regarding to this

-- 
P?ter
