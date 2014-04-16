From: ta.omasab@gmail.com (Thomas Abraham)
Date: Wed, 16 Apr 2014 20:25:24 +0530
Subject: [PATCH 5/6] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <534E9859.7000307@samsung.com>
References: <1397554134-11827-1-git-send-email-sachin.kamat@linaro.org>
 <1397554134-11827-6-git-send-email-sachin.kamat@linaro.org>
 <534E8AE1.4010402@samsung.com> <4516298.kO98TB1Ozz@wuerfel>
 <534E9859.7000307@samsung.com>
Message-ID: <CAJuA9ajXa+mejdUvWATHjmmin8hoRhX0wueg5g8rDbJR4AWZ7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 8:18 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> On 16.04.2014 16:31, Arnd Bergmann wrote:
>>
>> On Wednesday 16 April 2014 15:51:29 Tomasz Figa wrote:
>>>
>>> On 15.04.2014 11:28, Sachin Kamat wrote:
>>>>
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> This makes it possible to enable the exynos platform as part of a
>>>> multiplatform kernel, in addition to keeping the single-platform
>>>> Exynos support.
>>>> sparsemem is currently not supported in multiplatform.
>>>
>>>
>>> Is this still true as of today?
>>>
>>> Otherwise looks fine.
>>
>>
>> sparsemem is still not supported in multiplatform, but after I looked
>> at it in more detail, I came to the conclusion that there is no
>> reason why it couldn't be. It just needs testing so we are confident
>> that it doesn't break other platforms, and we need to find good
>> platform-independent values for MAX_PHYSMEM_BITS and SECTION_SIZE_BITS
>> to put into asm/memory.h, since we can't have them set in mach/memory.h
>> for multiplatform.
>>
>> Looking at my patch again now, I would actually prefer to kill off
>> the single-platform support for exynos right away. I don't see
>> any reason to keep it now, and it complicates the test matrix.
>
>
> That would be the best option, assuming that it wouldn't introduce feature
> regressions. Unfortunately there is still ongoing work on cpufreq driver to
> make it multiplatform-aware, so dropping single platform support right now
> would introduce at least this one regression.
>
> Thomas, is there any progress on new version of Exynos cpufreq rework
> series?

Hi Tomasz,

Yes, I am preparing the fourth version of the cpufreq patches and will
post it next week. Mostly, the changes will be addressing your review
comments.

Thanks,
Thomas.

>
> Best regards,
> Tomasz
