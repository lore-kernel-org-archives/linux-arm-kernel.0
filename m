From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Mon, 8 Aug 2016 15:30:08 -0600
Subject: [PATCH] exynos-drm: Fix unsupported GEM memory type error message
 to be clear
In-Reply-To: <20160808165657.GB5959@kozik-book>
References: <1470448206-16538-1-git-send-email-shuahkh@osg.samsung.com>
 <20160808165657.GB5959@kozik-book>
Message-ID: <57A8F9E0.5000804@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2016 10:56 AM, Krzysztof Kozlowski wrote:
> On Fri, Aug 05, 2016 at 07:50:06PM -0600, Shuah Khan wrote:
>> Fix unsupported GEM memory type error message to include the memory type
>> information.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>  drivers/gpu/drm/exynos/exynos_drm_fb.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
>> index e016640..c9315df 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
>> @@ -55,11 +55,11 @@ static int check_fb_gem_memory_type(struct drm_device *drm_dev,
>>  	flags = exynos_gem->flags;
>>  
>>  	/*
>> -	 * without iommu support, not support physically non-continuous memory
>> +	 * without iommu support, not support physically non-contiguous memory
> 
> While at it, how about changing entire sentence to something in English? :)

Yes I can do that. Will send v2 :)

> 
> Best regards,
> Krzysztof
> 
>>  	 * for framebuffer.
>>  	 */
>>  	if (IS_NONCONTIG_BUFFER(flags)) {
>> -		DRM_ERROR("cannot use this gem memory type for fb.\n");
>> +		DRM_ERROR("Non-continguous GEM memory is not supported.\n");
>>  		return -EINVAL;
>>  	}
>>  
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
