From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 28 Mar 2016 22:41:02 -0400
Subject: [PATCH 0/3] drm/exynos: Kconfig dependency fixes
In-Reply-To: <56F9DE63.6050808@samsung.com>
References: <1459214937-18686-1-git-send-email-javier@osg.samsung.com>
 <56F9DE63.6050808@samsung.com>
Message-ID: <56F9EB3E.5080000@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Seung-Woo,

Thanks a lot for your feedback.

On 03/28/2016 09:46 PM, Seung-Woo Kim wrote:
> Hi Javier,
> 
> On 2016? 03? 29? 10:28, Javier Martinez Canillas wrote:
>> Hello Inki,
>>
>> This patch series contains some fixes for the Kconfig symbol dependencies
>> of the Exynos DRM driver. They make sure that the Exynos DRM components
>> and the media platform drivers that makes use of the same HW IP block are
>> not enabled at the same time.
>>
>> Best regards,
>> Javier
>>
>>
>> Javier Martinez Canillas (3):
>>   drm/exynos: Use VIDEO_SAMSUNG_S5P_G2D=n as G2D Kconfig dependency
>>   drm/exynos: Use VIDEO_SAMSUNG_EXYNOS_GSC=n as GSC Kconfig dependency
>>   drm/exynos: Make DRM_EXYNOS_FIMC depend on VIDEO_S5P_FIMC=n
> 
> In G2D case, there is only one instance, but for the other cases, there
> are several instances and in my environment, I enable both drivers on
> v4l2 and drm FIMC/GSC.
> 
> So, IMHO, the not-enabled v4l2 dependency is not really required for drm
> fimc and drm gsc.
>

I'm confused, it was you who added the depends on !VIDEO_SAMSUNG_EXYNOS_GSC
for DRM_EXYNOS_GSC in commit aeefb36832e5 ("drm/exynos: gsc: add device tree
support and remove usage of static mappings").

>From the commit message "The driver cannot be used simultaneously with V4L2
Mem2Mem GScaller driver thought". Did that assumption changed and the depend
should be removed then? or maybe I misunderstood what you meant.

Now, I'm not really sure about FIMC either, it was feedback I got from this
patch [0]. Could you please take a look to that and let me know if enabling
these drivers simultaneously makes sense then?

> Best Regards,
> - Seung-Woo Kim
> 
>>
>>  drivers/gpu/drm/exynos/Kconfig | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
> 

[0]: https://lkml.org/lkml/2016/3/23/292

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
