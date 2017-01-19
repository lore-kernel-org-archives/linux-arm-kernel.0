From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 19 Jan 2017 11:19:05 -0300
Subject: [PATCH 1/2] [media] exynos-gsc: Fix unbalanced
 pm_runtime_enable() error
In-Reply-To: <74767acf-052e-80ec-7172-67306b73b691@samsung.com>
References: <CGME20170118003024epcas5p34baff888a902351d9168d74f5ecbf293@epcas5p3.samsung.com>
 <1484699402-28738-1-git-send-email-javier@osg.samsung.com>
 <74767acf-052e-80ec-7172-67306b73b691@samsung.com>
Message-ID: <2722f760-d1ef-d842-ed3e-aff144ccc72c@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marek,

On 01/19/2017 11:12 AM, Marek Szyprowski wrote:
> Hi Javier,
> 
> On 2017-01-18 01:30, Javier Martinez Canillas wrote:
>> Commit a006c04e6218 ("[media] exynos-gsc: Fixup clock management at
>> ->remove()") changed the driver's .remove function logic to fist do
>> a pm_runtime_get_sync() to make sure the device is powered before
>> attempting to gate the gsc clock.
>>
>> But the commit also removed a pm_runtime_disable() call that leads
>> to an unbalanced pm_runtime_enable() error if the driver is removed
>> and re-probed:
>>
>> exynos-gsc 13e00000.video-scaler: Unbalanced pm_runtime_enable!
>> exynos-gsc 13e10000.video-scaler: Unbalanced pm_runtime_enable!
>>
>> Fixes: a006c04e6218 ("[media] exynos-gsc: Fixup clock management at ->remove()")
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> I must have mixed something during the rebase of the Ulf's patch, because
> the original one kept pm_runtime_disable in the right place:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317678.html
> 
> I'm really sorry.
> 

Ah, I see. No worries.

> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 

Thanks a lot for your review.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
