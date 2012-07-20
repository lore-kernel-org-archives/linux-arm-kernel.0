From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 20 Jul 2012 12:09:52 +0200
Subject: [PATCH V2 1/7] ARM: SAMSUNG: add additional registers and SFR
 definitions for writeback
In-Reply-To: <CAEC9eQP01q+ddhA9Q4VQcm8wuvJXmR5KvAVZgX6MEdFLstST0g@mail.gmail.com>
References: <1342591053-7092-1-git-send-email-l.krishna@samsung.com>
 <1342591053-7092-2-git-send-email-l.krishna@samsung.com>
 <009c01cd64b1$bd3a8390$37af8ab0$%szyprowski@samsung.com>
 <CAEC9eQP01q+ddhA9Q4VQcm8wuvJXmR5KvAVZgX6MEdFLstST0g@mail.gmail.com>
Message-ID: <50092E70.6090806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2012 09:09 AM, Ajay kumar wrote:
>>> +config FB_EXYNOS_FIMD_V8
>>> +     bool "register extensions for FIMD version 8"
>>> +     depends on ARCH_EXYNOS5
>>> +     ---help---
>>> +     This uses register extensions for FIMD version 8
>>> +
>>>   config FB_S3C_DEBUG_REGWRITE
>>>          bool "Debug register writes"
>>>          depends on FB_S3C
>>
>> Do we really need these defines in arch/arm/plat-samsung/include/plat/regs-fb* ?
>> IMHO they should be moved from arch/arm to drivers/video to live together with the driver.
>> They are not a part of core platform code. I thought that there have been some patches
>> cleaning up regs-fb mess a long time ago, but it looks they didn't get their way to
>> mainline.
>
> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/5826
>
> These patches are merged.
> I created the patchset. I felt it was redundant to have regs-fb.h in
> individual samsung boards(arch/arm/mach-s*),
> so I moved them to plat-samsung. We still need to move plat/regs-fb.h
> to driver side.

Great. These headers are now used by drivers/video/s3c-fb.c and 
drivers/gpu/drm/exynos/exynos_drm_fimd.c, so we probably need to merge
them into one file under include/video.

--

Regards,
Sylwester
