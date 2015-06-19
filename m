From: inki.dae@samsung.com (Inki Dae)
Date: Fri, 19 Jun 2015 15:03:20 +0900
Subject: [PATCH] drm/exynos: Remove unused vma field of exynos_drm_gem_obj
In-Reply-To: <CAJKOXPe5M-nxjcuopOo7GiSHELG6pQ8VOTN8VMVvt=AZ+AM_HA@mail.gmail.com>
References: <1434691409-9509-1-git-send-email-k.kozlowski@samsung.com>
 <5583A87F.5090807@samsung.com>
 <CAJKOXPe5M-nxjcuopOo7GiSHELG6pQ8VOTN8VMVvt=AZ+AM_HA@mail.gmail.com>
Message-ID: <5583B0A8.3040908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015? 06? 19? 14:46, Krzysztof Kozlowski wrote:
> 2015-06-19 14:28 GMT+09:00 Inki Dae <inki.dae@samsung.com>:
>> On 2015? 06? 19? 14:23, Krzysztof Kozlowski wrote:
>>> The field 'vma' of 'exynos_drm_gem_obj' structure was introduced in
>>> 2a3098ff6c21 ("drm/exynos: add userptr feature for g2d module") but is
>>> not referenced anywhere.
>>>
>>> One instance of 'exynos_drm_gem_obj' may be mapped to multiple
>>> user-space VMAs so 'vma' field does not look useful anyway.
>>
>> Krzysztof,
>>
>> The vma member would be removed by below patch,
>> http://lists.freedesktop.org/archives/dri-devel/2015-May/082764.html
>>
> 
> I think it is a different object. The patch above removes it from
> struct g2d_cmdlist_userptr.
> However I removed it from struct exynos_drm_gem_obj, where it was
> never referenced.

Ah, right. There was my mistake.

Thanks,
Inki Dae

> 
> Best regards,
> Krzysztof
> 
>> Thanks,
>> Inki Dae
>>
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> ---
>>>  drivers/gpu/drm/exynos/exynos_drm_gem.h | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.h b/drivers/gpu/drm/exynos/exynos_drm_gem.h
>>> index 308173cb4f0a..6f42e2248288 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.h
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.h
>>> @@ -61,7 +61,6 @@ struct exynos_drm_gem_buf {
>>>   *   or at framebuffer creation.
>>>   * @size: size requested from user, in bytes and this size is aligned
>>>   *   in page unit.
>>> - * @vma: a pointer to vm_area.
>>>   * @flags: indicate memory type to allocated buffer and cache attruibute.
>>>   *
>>>   * P.S. this object would be transferred to user as kms_bo.handle so
>>> @@ -71,7 +70,6 @@ struct exynos_drm_gem_obj {
>>>       struct drm_gem_object           base;
>>>       struct exynos_drm_gem_buf       *buffer;
>>>       unsigned long                   size;
>>> -     struct vm_area_struct           *vma;
>>>       unsigned int                    flags;
>>>  };
>>>
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
