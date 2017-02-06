From: keescook@chromium.org (Kees Cook)
Date: Mon, 6 Feb 2017 12:13:38 -0800
Subject: [PATCHv2 2/2] arch: Rename CONFIG_DEBUG_RODATA and
 CONFIG_DEBUG_MODULE_RONX
In-Reply-To: <e9b6bcba-8488-9502-aebf-f260396671d5@redhat.com>
References: <1486144343-24998-1-git-send-email-labbott@redhat.com>
 <1486144343-24998-3-git-send-email-labbott@redhat.com>
 <CAGXu5j+BX_+ymWQztqtOQE-A8yFuR5sdL++46wOvi-iBGLEK-A@mail.gmail.com>
 <e9b6bcba-8488-9502-aebf-f260396671d5@redhat.com>
Message-ID: <CAGXu5jKS0_a8Nq+eJN4TN142fxrtEyO7qD9FB8gDCju6PA5xEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2017 at 10:49 AM, Laura Abbott <labbott@redhat.com> wrote:
> On 02/03/2017 12:03 PM, Kees Cook wrote:
>> On Fri, Feb 3, 2017 at 9:52 AM, Laura Abbott <labbott@redhat.com> wrote:
>>>
>>> Both of these options are poorly named. The features they provide are
>>> necessary for system security and should not be considered debug only.
>>> Change the name to something that accurately describes what these
>>> options do.
>>
>> It may help to explicitly call out the name change from/to in the
>> commit message.
>>
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>> [...]
>>> diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
>>> index ca39c04..beea2cc 100644
>>> --- a/arch/arm/configs/aspeed_g4_defconfig
>>> +++ b/arch/arm/configs/aspeed_g4_defconfig
>>> @@ -25,7 +25,6 @@ CONFIG_MODULE_UNLOAD=y
>>>  # CONFIG_ARCH_MULTI_V7 is not set
>>>  CONFIG_ARCH_ASPEED=y
>>>  CONFIG_MACH_ASPEED_G4=y
>>> -CONFIG_DEBUG_RODATA=y
>>>  CONFIG_AEABI=y
>>>  CONFIG_UACCESS_WITH_MEMCPY=y
>>>  CONFIG_SECCOMP=y
>>
>> Are these defconfig cases correct (dropping DEBUG_RODATA without
>> adding STRICT_KERNEL_RWX)?
>>
>
> Yes, I think these need to be updated to the new config option since
> these are not CPUv7
>
>
>> Who should carry this series, btw?
>>
>
> An excellent question :)
>
> Would you be willing to carry it with Acks?

Yeah, I can push this via the KSPP tree: it's cross-architecture, so
it seems like this should go either through my tree or through akpm's
tree.

Are the arch maintainers okay with that?

-Kees

-- 
Kees Cook
Pixel Security
