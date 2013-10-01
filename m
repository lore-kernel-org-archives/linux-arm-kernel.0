From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 1 Oct 2013 09:35:43 -0400
Subject: [PATCH v2 3/5] dma: Allow TI_EDMA selectable for ARCH_KEYSTONE
In-Reply-To: <20131001015454.GA16684@intel.com>
References: <1380580887-24249-1-git-send-email-santosh.shilimkar@ti.com>
 <1380580887-24249-4-git-send-email-santosh.shilimkar@ti.com>
 <20131001015454.GA16684@intel.com>
Message-ID: <524ACFAF.7020802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 September 2013 09:54 PM, Vinod Koul wrote:
> On Mon, Sep 30, 2013 at 06:41:25PM -0400, Santosh Shilimkar wrote:
>> Allow the TI_EDMA to be built for ARCH_KEYSTONE which also supports
>> the EDMA IP.
>>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> Vinod,
>> I need your ack on this patch to carry $subject patch via arm-soc tree
>> to avoid the unmet dependency warnings.
> Sure, but too many dependency fixes have been popoing up for this part and this
> IIRC is third patch! Something doesn't seem right, hopefully am wrong..
>
I think it mainly because EDMA support is just merged last cycle and few SOCs
which use the EDMA trying to enable them now.
 
> I have a patch in my -next from Josh which selects TI_PRIV_EDMA for this...
> 
I looked at your next patch which is fixing the TI_EDMA dependency.
If you prefer to merge $subject patch via your tree, thats fine as well.
Juts give me a stable branch targeted for 3.13 and I shall merge your branch
and apply other patches on top of it.

Since it was very trivial patch, I thought its easy to carry via arm-soc
with your ack.

>>
>>  drivers/dma/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 526ec77..b1dde16 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -195,7 +195,7 @@ config SIRF_DMA
>>  
>>  config TI_EDMA
>>  	bool "TI EDMA support"
>> -	depends on ARCH_DAVINCI || ARCH_OMAP
>> +	depends on ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE
>>  	select DMA_ENGINE
>>  	select DMA_VIRTUAL_CHANNELS
>>  	default n
>> -- 
>> 1.7.9.5
>>
> 
