From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 26 Mar 2015 14:32:58 +0200
Subject: [PATCH v2 4/7] dmaengine: omap-dma: Use defines for dma channels
 and request count
In-Reply-To: <20150326105712.GL32683@intel.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
 <1426080210-841-5-git-send-email-peter.ujfalusi@ti.com>
 <20150326105712.GL32683@intel.com>
Message-ID: <5513FC7A.7090708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2015 12:57 PM, Vinod Koul wrote:
> On Wed, Mar 11, 2015 at 03:23:27PM +0200, Peter Ujfalusi wrote:
>> Instead of magic numbers in the code, use define for number of logical DMA
>> channels and DMA requests.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/omap-dma.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
>> index 7dd6dd121681..56c33e93dd24 100644
>> --- a/drivers/dma/omap-dma.c
>> +++ b/drivers/dma/omap-dma.c
>> @@ -22,6 +22,9 @@
>>  
>>  #include "virt-dma.h"
>>  
>> +#define OMAP_SDMA_REQUESTS	127
>> +#define OMAP_SDMA_CHANNELS	32
> Again why dont we put these things in DT ?

They are in DT, the next patch will take the needed information from there and
uses these values as fallback values in case they are missing for some reason.

-- 
P?ter
