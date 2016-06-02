From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 2 Jun 2016 09:48:17 -0700
Subject: [PATCH 01/32] arm64: Add platform selection for BCM2835.
In-Reply-To: <4e72ae37-a018-a17d-6a58-8450db58d1c7@broadcom.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-2-git-send-email-kraxel@redhat.com>
 <574F5881.4060008@gmail.com> <1464849936.24775.33.camel@redhat.com>
 <4e72ae37-a018-a17d-6a58-8450db58d1c7@broadcom.com>
Message-ID: <57506351.3060706@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reply inline.

On 16-06-02 09:25 AM, Ray Jui wrote:
>
>
> On 6/1/2016 11:45 PM, Gerd Hoffmann wrote:
>>>>  config ARCH_BCM2835
>>>>      bool "Broadcom BCM2835 family"
>>>> -    depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
>>>> +    depends on ARCH_MULTI_V6 || ARCH_MULTI_V7 || ARM64
>>>
>>> Humm, what does that achieve?
>>
>> Nothing ;)
>>
>> Slipped through unnoticed, I'll drop it.
>>
>>>> +config ARCH_BCM
>>>> +    bool "Broadcom SoC Support"
>>>> +    help
>>>> +      This enables support for Broadcom ARM based SoC chips
>>>
>>> menuconfig maybe?
>>
>> There isn't any in arch/arm64/Kconfig.platforms right now, so I didn't
>> feel like introducing one.  Also the dependency should have pretty much
>> the same effect .

No need to add ARCH_BCM
.
>>
>>>> +config ARCH_BCM2835
>>>> +    bool "Broadcom BCM2835 family"
>>>> +    depends on ARCH_BCM
>>>> +    select ARCH_REQUIRE_GPIOLIB
>>>> +    select CLKSRC_OF
>>>> +    select PINCTRL
>>>> +    select PINCTRL_BCM2835
>>>> +    select ARM_AMBA
>>>> +    select ARM_TIMER_SP804
>>>> +    select HAVE_ARM_ARCH_TIMER
>>>> +    help
>>>> +      This enables support for the Broadcom BCM2837 SoC.
>>>> +      This SoC is used in the Raspberry Pi 3 device.
>>>> +
>>>>  config ARCH_BCM_IPROC
>>>>      bool "Broadcom iProc SoC Family"
>>>> +    depends on ARCH_BCM
>>>
>>> Does not seem necessary nor adding anything here.
>>
>> Added for consistency.  When we add ARCH_BCM all ARCH_BCM_* should
>> depend on it ...
>>
>> We could also do it the other way around: make ARCH_BCM a hidden bool
>> and have ARCH_BCM_* select it.
>
> Yes, this is probably better.
>
> ARCH_BCM_IPROC is currently enabled in arch/arm64/configs/defconfig. By
> adding a dependency here without enabling ARCH_BCM in arm64 defconfig,
> this effectively disables ARCH_BCM_IPROC from arm64 defconfig.

There is no need to add ARCH_BCM though?

>
>>
>> cheers,
>>   Gerd
>>
