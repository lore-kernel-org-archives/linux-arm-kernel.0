From: claudio@evidence.eu.com (Claudio Scordino)
Date: Mon, 23 Nov 2009 09:30:11 +0100
Subject: [PATCH TRIVIAL] atmel_lcdfb.c: Fix sinfo->irqbase from %lu to
	%d in dev_info().
In-Reply-To: <alpine.LSU.2.00.0910091730560.19284@wotan.suse.de>
References: <1255083621-25147-1-git-send-email-nicolas.ferre@atmel.com>
	<alpine.LSU.2.00.0910091730560.19284@wotan.suse.de>
Message-ID: <4B0A4813.7060305@evidence.eu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jiri Kosina ha scritto:
> On Fri, 9 Oct 2009, Nicolas Ferre wrote:
> 
>> From: Claudio Scordino <claudio@evidence.eu.com>
>>
>> This patch fixes a type mismatch when calling dev_info() in the
>> atmel_lcdfb.c driver.
>>
>> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  drivers/video/atmel_lcdfb.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
>> index 2830ffd..317afab 100644
>> --- a/drivers/video/atmel_lcdfb.c
>> +++ b/drivers/video/atmel_lcdfb.c
>> @@ -959,7 +959,7 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>>  	if (sinfo->atmel_lcdfb_power_control)
>>  		sinfo->atmel_lcdfb_power_control(1);
>>  
>> -	dev_info(dev, "fb%d: Atmel LCDC at 0x%08lx (mapped at %p), irq %lu\n",
>> +	dev_info(dev, "fb%d: Atmel LCDC at 0x%08lx (mapped at %p), irq %d\n",
>>  		       info->node, info->fix.mmio_start, sinfo->mmio, sinfo->irq_base);
>>  
>>  	return 0;
> 
> Applied, thanks.
> 

Hi,

    may I ask you the current status of this patch ? I noticed that it
has not been merged, yet.

Do we have any idea when it will be done ?

Since it is a trivial fix, I think it should be merged before the
release of v2.6.32 (i.e., waiting the next merge window does not make
much sense for such a trivial fix...).

Many thanks,

             Claudio
