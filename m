From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 09 Sep 2010 10:44:14 +0900
Subject: [PATCH 2/4] ARM: Samsung: s5p-fimc: fix dma coherent mask
In-Reply-To: <000301cb4fb7$b4448530$1ccd8f90$%kim@samsung.com>
References: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
	<1283745044-15514-3-git-send-email-m.szyprowski@samsung.com>
	<000301cb4fb7$b4448530$1ccd8f90$%kim@samsung.com>
Message-ID: <4C883BEE.2070503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 2010-09-09 09:41, Kukjin Kim pisze:
> Marek Szyprowski wrote:
>>
>> FIMC driver uses DMA_coherent allocator, which requires proper dma mask
>> to be set.
>>
>> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>> ---
>>   arch/arm/plat-s5p/dev-fimc0.c |    2 ++
>>   arch/arm/plat-s5p/dev-fimc1.c |    2 ++
>>   arch/arm/plat-s5p/dev-fimc2.c |    2 ++
>>   3 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-s5p/dev-fimc0.c b/arch/arm/plat-s5p/dev-fimc0.c
>> index d3f1a9b..9f26096 100644
>> --- a/arch/arm/plat-s5p/dev-fimc0.c
>> +++ b/arch/arm/plat-s5p/dev-fimc0.c
>> @@ -33,4 +33,6 @@ struct platform_device s5p_device_fimc0 = {
>>   	.id		= 0,
>>   	.num_resources	= ARRAY_SIZE(s5p_fimc0_resource),
>>   	.resource	= s5p_fimc0_resource,
>> +	.dev.dma_mask	  =&s5p_device_fimc0.dev.coherent_dma_mask,
>> +	.dev.coherent_dma_mask = 0xffffffffUL,
>
> Ok...but I prefer following style :-)
> Could you please re-submit your this patch?

OK, I will update the style and resubmit the patch.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
