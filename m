From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 13 Mar 2014 15:40:05 +0200
Subject: [alsa-devel] [PATCH 13/18] dma: edma: Print the direction value
 as well when it is not supported
In-Reply-To: <1394715793.28803.240.camel@smile.fi.intel.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
 <1394702320-21743-14-git-send-email-peter.ujfalusi@ti.com>
 <1394715793.28803.240.camel@smile.fi.intel.com>
Message-ID: <5321B535.5040802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2014 03:03 PM, Shevchenko, Andriy wrote:
> On Thu, 2014-03-13 at 11:18 +0200, Peter Ujfalusi wrote:
>> In case of not supported direction it is better to print the direction also.
>> It is unlikely, but in such an event it helps with the debugging.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/edma.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>> index 47abaac7eb18..69dd4e3de67e 100644
>> --- a/drivers/dma/edma.c
>> +++ b/drivers/dma/edma.c
>> @@ -426,7 +426,7 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>>  		dev_width = echan->cfg.dst_addr_width;
>>  		burst = echan->cfg.dst_maxburst;
>>  	} else {
>> -		dev_err(dev, "%s: bad direction?\n", __func__);
>> +		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);
> 
> Is it possible to have direction less than zero? Maybe %u?

It is 'enum dma_transfer_direction direction'. %d should be fine.

> 
>>  		return NULL;
>>  	}
>>  
>> @@ -519,7 +519,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
>>  		dev_width = echan->cfg.dst_addr_width;
>>  		burst = echan->cfg.dst_maxburst;
>>  	} else {
>> -		dev_err(dev, "%s: bad direction?\n", __func__);
>> +		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);
> 
> Ditto.
> 
>>  		return NULL;
>>  	}
>>  
> 
> 


-- 
P?ter
