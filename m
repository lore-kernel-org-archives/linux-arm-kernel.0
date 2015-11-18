From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 18 Nov 2015 10:09:22 +0900
Subject: [PATCH] ARM: sunxi: Re-enable SID driver in multi_v7_defconfig
In-Reply-To: <20151117090309.09ACC6C80816@dd34104.kasserver.com>
References: <1447724947-4851-1-git-send-email-public_timo.s@silentcreek.de>
 <564A8CAD.8050004@samsung.com> <1447747294.6274.8.camel@silentcreek.de>
 <CAJKOXPdBnMcoFDuVMm3zgDcZwDVfeotySvAbO+bvzDX0T-AX4g@mail.gmail.com>
 <20151117090309.09ACC6C80816@dd34104.kasserver.com>
Message-ID: <564BCFC2.8050506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.11.2015 18:03, Timo Sigurdsson wrote:
> Hi,
> 
> Krzysztof Kozlowski schrieb am 17.11.2015 09:21:
> 
> [...]
> 
>>>>> @@ -450,8 +431,7 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
>>>>>  CONFIG_MEDIA_CONTROLLER=y
>>>>>  CONFIG_VIDEO_V4L2_SUBDEV_API=y
>>>>>  CONFIG_MEDIA_USB_SUPPORT=y
>>>>> -CONFIG_USB_VIDEO_CLASS=y
>>>>> -CONFIG_USB_GSPCA=y
>>>>> +CONFIG_USB_VIDEO_CLASS=m
>>>>>  CONFIG_V4L_PLATFORM_DRIVERS=y
>>>>>  CONFIG_SOC_CAMERA=m
>>>>>  CONFIG_SOC_CAMERA_PLATFORM=m
>>>>> @@ -465,28 +445,25 @@ CONFIG_DRM=y
>>>>>  CONFIG_DRM_I2C_ADV7511=m
>>>>>  # CONFIG_DRM_I2C_CH7006 is not set
>>>>>  # CONFIG_DRM_I2C_SIL164 is not set
>>>>> -CONFIG_DRM_NXP_PTN3460=m
>>>>> -CONFIG_DRM_PARADE_PS8622=m
>>>>>  CONFIG_DRM_NOUVEAU=m
>>>>>  CONFIG_DRM_EXYNOS=m
>>>>> -CONFIG_DRM_EXYNOS_DSI=y
>>>>>  CONFIG_DRM_EXYNOS_FIMD=y
>>>>> -CONFIG_DRM_EXYNOS_HDMI=y
>>>>
>>>> I would prefer leaving the EXYNOS_HDMI. Dependencies are now not enabled
>>>> but we are fixing it in:
>>>> http://www.spinics.net/lists/dri-devel/msg93299.html
>>>
>>> I think the problem here is that I don't see this patch in linux-next
>>> yet.
>>>
>>
>> Indeed... and I don't know when it will go there so actually maybe it
>> should be removed... but in the same time removing DRM_EXYNOS_HDMI
>> will probably make some conflicts because mentioned patch will go
>> through Exynos DRM tree or Samsung SoC.
> 
> Since you suggested to split my patch into two, I might as well just
> hold off the "cleanup" patch until Andrzejs patch hits linux-next.
> Is that ok?

>From my point of view - OK. However this may take time... I don't know
when Andrzej's patch will be applied so for me would work also
savedefconfig without removing HDMI.

Best regards,
Krzysztof
