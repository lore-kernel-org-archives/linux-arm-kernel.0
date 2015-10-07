From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 7 Oct 2015 11:26:43 +0200
Subject: [PATCH v5 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <5614DFBC.8060105@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
 <5614BADD.1070307@rock-chips.com> <5614DBE2.6080102@osg.samsung.com>
 <5614DFBC.8060105@rock-chips.com>
Message-ID: <5614E553.6060108@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Yakir,

On 10/07/2015 11:02 AM, Yakir Yang wrote:
> Hi Javier,
> 
> On 10/07/2015 04:46 PM, Javier Martinez Canillas wrote:
>> Hello Yakir,
>>
>> On 10/07/2015 08:25 AM, Yakir Yang wrote:
>>> Hi all,
>>>
>>> Friendly ping.....   :)
>>>
>>>
>>> Best regards,
>>> - Yakir
>>>
>>>
>> Do you have a tree that I can use to test these patches?
> 
> Wow, thanks a lot, I do have a tree on github [https://github.com/yakir-Yang/linux/tree/analogix_dp],
> crossing my finger, wish things works......    ;)
>

I tried your analogix_dp branch on an Exynos5800 Peach Pi Chromebook
but the machine didn't boot. Unfortunately I need to do some soldering
to have a serial console on this board so don't have a kernel boot log.

I'll let you know if I can get more info about this issue.

Also, there is Kconfig recursive dependency that you may want to fix:

$ make exynos_defconfig
drivers/video/fbdev/Kconfig:5:error: recursive dependency detected!
drivers/video/fbdev/Kconfig:5: symbol FB is selected by DRM_KMS_FB_HELPER
drivers/gpu/drm/Kconfig:34: symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
drivers/gpu/drm/Kconfig:28: symbol DRM_KMS_HELPER is selected by DRM_ANALOGIX_DP
drivers/gpu/drm/bridge/analogix/Kconfig:1: symbol DRM_ANALOGIX_DP is selected by DRM_EXYNOS_DP
drivers/gpu/drm/exynos/Kconfig:57: symbol DRM_EXYNOS_DP depends on DRM_EXYNOS_FIMD
drivers/gpu/drm/exynos/Kconfig:19: symbol DRM_EXYNOS_FIMD depends on FB_S3C
drivers/video/fbdev/Kconfig:2023: symbol FB_S3C depends on FB
 
> Thanks,
> - Yakir
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
