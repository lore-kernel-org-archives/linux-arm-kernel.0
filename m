From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 21 Sep 2011 14:53:47 +0530
Subject: [RESEND PATCH 2/3] ARM: EXYNOS4: Update consistent DMA size to 8MB
In-Reply-To: <23185691.178841316589732769.JavaMail.weblogic@epv6ml02>
References: <23185691.178841316589732769.JavaMail.weblogic@epv6ml02>
Message-ID: <4E79AD23.8050807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 21 September 2011 12:52 PM, HATIMALI RV wrote:
> Hello Mr. Park,
>
> As I mentioned in the cover letter of v1 patch set (http://www.spinics.net/lists/arm-kernel/msg138054.html),
> this is a temporary patch which is just for testing HDMI on SMDKV310.
> Once CMA gets merged, we will be using that to allocate memory.
>
The macro definition CONSISTENT_DMA_SIZE has been removed and has been 
replaced by a function call. Please refer to this patch.

http://www.spinics.net/lists/linux-samsung-soc/msg06627.html

> Thanks for your review.
>
> Regards,
> Hatim Ali
>
> ------- Original Message -------
> Sender : Kyungmin Park<kmpark@infradead.org>
> Date   : Sep 21, 2011 11:55 (GMT+05:30)
> Title  : Re: [RESEND PATCH 2/3] ARM: EXYNOS4: Update consistent DMA size to 8MB
>
> Hi,
>
> As I know,  CONSISTENT_DMA_SIZE is removed, please use the updated APIs.
>
> Thank you,
> Kyungmin Park
>
> On Wed, Sep 21, 2011 at 2:44 PM, Hatim Ali<hatim.rv@samsung.com>  wrote:
>> Change the consistent DMA allocation to 8MB to support the
>> TVOUT driver.
>>
>> NOTE: Once CMA support is merged into mainline, we will use it for memory
>> allocation.
>>
>> Signed-off-by: Hatim Ali<hatim.rv@samsung.com>
>> ---
>>   arch/arm/mach-exynos4/include/mach/memory.h |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos4/include/mach/memory.h b/arch/arm/mach-exynos4/include/mach/memory.h
>> index 374ef2c..7549742 100644
>> --- a/arch/arm/mach-exynos4/include/mach/memory.h
>> +++ b/arch/arm/mach-exynos4/include/mach/memory.h
>> @@ -15,6 +15,8 @@
>>
>>   #define PLAT_PHYS_OFFSET               UL(0x40000000)
>>
>> +#define CONSISTENT_DMA_SIZE            SZ_8M
>> +
>>   /* Maximum of 256MiB in one bank */
>>   #define MAX_PHYSMEM_BITS       32
>>   #define SECTION_SIZE_BITS      28
>> --
>> 1.7.2.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> N?????r??y????b?X????v?^?)??{.n?+????{?????x,????????}???? z?&j:+v???????zZ+??+zf???h???~????i???z?
?w?????????&?)??fl===


-- 
Tushar Behera
