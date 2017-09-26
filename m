From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 26 Sep 2017 14:33:07 +0800
Subject: [PATCH 7/7] drm/rockchip: Cocci spatch "vma_pages"
In-Reply-To: <20170926051241.rwzpxlk4sfju7ctv@phenom.ffwll.local>
References: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
 <1505946334393-988165015-7-diffsplit-thomas@m3y3r.de>
 <d2298979-3094-744c-3d28-76a0ba4a1137@rock-chips.com>
 <20170926051241.rwzpxlk4sfju7ctv@phenom.ffwll.local>
Message-ID: <b6f6fb10-d8ef-1b6e-0770-898d7277a983@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?09?26? 13:12, Daniel Vetter wrote:
> On Thu, Sep 21, 2017 at 09:02:22AM +0800, Mark yao wrote:
>> On 2017?09?21? 06:29, Thomas Meyer wrote:
>>> Use vma_pages function on vma object instead of explicit computation.
>>> Found by coccinelle spatch "api/vma_pages.cocci"
>>>
>>> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
>>> ---
>> Looks good for me:
>> Acked-by: Mark Yao <mark.yao@rock-chips.com>
> Once more a maintainer who acks a patch and doesn't push it. This is
> really confusing, who exactly do you expect to handle this patch for you?
>
> Please push to drm-misc-next (also for future patches), thanks.
> -Daniel

Hi Daniel
I Saw the patch title is "[PATCH 7/7]", I guessed it's one of a series of patches and maybe it can pushed by series.

Ok, Pushed it to drm-misc-next.

>
>>> diff -u -p a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>>> @@ -220,7 +220,7 @@ static int rockchip_drm_gem_object_mmap_
>>>    {
>>>    	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
>>>    	unsigned int i, count = obj->size >> PAGE_SHIFT;
>>> -	unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>>> +	unsigned long user_count = vma_pages(vma);
>>>    	unsigned long uaddr = vma->vm_start;
>>>    	unsigned long offset = vma->vm_pgoff;
>>>    	unsigned long end = user_count + offset;
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>>
>>>
>>>
>> -- 
>> ?ark Yao
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
?ark Ya
