From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 4 May 2015 20:54:47 +0300
Subject: [PATCH 1/3] ARM: s3c24xx: add dma_coherent_mask for DMA devices
In-Reply-To: <CAJKOXPfbF0RDPisY-PvKKKVT1kHDrR60b7VmcjTkco5UPm-WTg@mail.gmail.com>
References: <1430676910-30657-1-git-send-email-anarsoul@gmail.com>
 <CAJKOXPfbF0RDPisY-PvKKKVT1kHDrR60b7VmcjTkco5UPm-WTg@mail.gmail.com>
Message-ID: <CA+E=qVf5MLsdV+U82Smv-weKQ3eJAEob7J+hdbhtZ-E1qrOsYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 4, 2015 at 6:42 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> 2015-05-04 3:15 GMT+09:00 Vasily Khoruzhick <anarsoul@gmail.com>:
>> Otherwise dma_alloc_coherent() fails.
>
> Could you say few more words about the failure?
> Also the patch looks like a candidate for CC-stable along with Fixes tag.

Hm, any call of dma_alloc_coherent() will fail for s3c24xx-dmac
device. For example, asoc dmaengine driver. What exactly do
you want me to precise?

>>
>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>> ---
>>  arch/arm/mach-s3c24xx/common.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
>> index bf50328..7ed0853 100644
>> --- a/arch/arm/mach-s3c24xx/common.c
>> +++ b/arch/arm/mach-s3c24xx/common.c
>> @@ -355,6 +355,7 @@ struct platform_device s3c2410_device_dma = {
>>         .resource       = s3c2410_dma_resource,
>>         .dev    = {
>>                 .platform_data  = &s3c2410_dma_platdata,
>> +               .coherent_dma_mask = ~0,
>
> DMA_BIT_MASK(32)?
>
>>         },
>>  };
>>  #endif
>> @@ -452,6 +453,7 @@ struct platform_device s3c2440_device_dma = {
>>         .resource       = s3c2410_dma_resource,
>>         .dev    = {
>>                 .platform_data  = &s3c2440_dma_platdata,
>> +               .coherent_dma_mask = ~0,
>
> Ditto.
>
> Best regards,
> Krzysztof
