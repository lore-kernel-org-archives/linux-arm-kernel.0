From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 25 Sep 2013 20:16:53 +0400
Subject: [PATCH v2 2/2] ARM: shmobile: Marzen: enable DMA for SDHI0
In-Reply-To: <20130925065549.GG1916@verge.net.au>
References: <201308252143.33458.sergei.shtylyov@cogentembedded.com>
 <201308252147.27210.sergei.shtylyov@cogentembedded.com>
 <20130925065549.GG1916@verge.net.au>
Message-ID: <52430C75.5090409@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09/25/2013 10:55 AM, Simon Horman wrote:

> [ Cc: Guennadi Liakhovetski ]

>> From: Max Filippov <max.filippov@cogentembedded.com>

>> Pass HPB-DMA slave IDs in the SDHI0 platform data to enable DMA in the SDHI
>> driver.

>> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
>> [Sergei: removed #include <mach/dma.h>]
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> Changes in version 2:
>> - refreshed the patch.

>>   arch/arm/mach-shmobile/board-marzen.c |    2 ++
>>   1 file changed, 2 insertions(+)

>> Index: renesas/arch/arm/mach-shmobile/board-marzen.c
>> ===================================================================
>> --- renesas.orig/arch/arm/mach-shmobile/board-marzen.c
>> +++ renesas/arch/arm/mach-shmobile/board-marzen.c
>> @@ -123,6 +123,8 @@ static struct resource sdhi0_resources[]
>>   };
>>
>>   static struct sh_mobile_sdhi_info sdhi0_platform_data = {
>> +	.dma_slave_tx = HPBDMA_SLAVE_SDHI0_TX,
>> +	.dma_slave_rx = HPBDMA_SLAVE_SDHI0_RX,
>>   	.tmio_flags = TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
>>   	.tmio_caps = MMC_CAP_SD_HIGHSPEED,
>>   };

> Hi,

> I am intending to queue up this change for v3.13.

    Thanks in advance. :-)

> I am wondering if you could give me some details of dependencies
> of this change on the previous patch. If possible I would
> like to apply this patch in a branch that does not include the previous patch.

    HPBDMA_SLAVE_* are defined there. I'm afraid it's not possible to apply 
this patch separately.

> Also, could you provide a patch to update the marzen defconfig?

    Yes, I intended to.

> Lastly, the driver does not seem to compile as it makes use of
> shdma_free_irq() which was removed by Guennadi in
> c1c63a14f4f2419d ("DMA: shdma: switch to managed resource allocation").

    Thanks for the information, I wasn't aware of that.

WBR, Sergei
