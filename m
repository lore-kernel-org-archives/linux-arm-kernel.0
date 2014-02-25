From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 25 Feb 2014 01:52:15 +0100
Subject: [PATCH 1/1] ARM: Exynos: Add generic compatible string
In-Reply-To: <530BE557.20106@samsung.com>
References: <1392809645-631-1-git-send-email-sachin.kamat@linaro.org>	<CAK9yfHyWG1ac6isTRSB3VWfxER9cSuDJHwY3b7svyEk9EozpWQ@mail.gmail.com>	<53075239.4010603@samsung.com>	<2200834.G3JJLYQl5i@wuerfel>	<53076F00.7000001@samsung.com>	<53077160.5030202@samsung.com>
 <CAK9yfHxiHkrf1xmSFbfoKqFFSCU6w4QqwPnQNdv1m1PGtrwsLQ@mail.gmail.com>
 <530BE557.20106@samsung.com>
Message-ID: <530BE93F.2070904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.02.2014 01:35, Kukjin Kim wrote:
> On 02/24/14 21:03, Sachin Kamat wrote:
>> On 21 February 2014 21:01, Tomasz Figa<t.figa@samsung.com>  wrote:
>>> On 21.02.2014 16:21, Tomasz Figa wrote:
>>>>
>>>> On 21.02.2014 15:48, Arnd Bergmann wrote:
>>>>>
>>>>> On Friday 21 February 2014 14:18:49 Tomasz Figa wrote:
>>>>>>
>>>>>>
>>>>>>> Now that we have a broader agreement on this, I think we can go
>>>>>>> ahead with the
>>>>>>> following steps as an initial approach:
>>>>>>> 1. Have a common machine file for both exynos4 and 5 files,
>>>>>>> mach-exynos-dt.c.
>>>>>>> 2. Introduce a generic compatible string "samsung,exynos".
>
> Well, I think, we need to consider to use compatible string
> "samsung,exynos" again because "exynos" name can be used on ARMv8 as
> well and I don't want to say that generic/common something is always
> good. So IMHO still using exynos4 and exynos5 would be better.

You can create a new compatible string (e.g. "samsung,exynos-armv8") for 
ARMv8 Exynos if support for one in mainline shows up and/or simply use 
another name for ARMv7 Exynos (e.g. "samsung,exynos-armv7").

>>>>>>> 3. Append this to the compatible property list for existing boards.
>>>>>>>
>>>>>>> If this plan looks OK, I can send across patches doing this.
>>>>>>>
>>>>>>
>>>>>> Looks good. I would also merge common.c with this resulting
>>>>>> mach-exynos-dt.c, as it would be the only user of the code there.
>>>>>
>>>>>
>>>>> Sounds good. While the naming is not important, I would just call the
>>>>> file 'exynos.c', in line with some of the other platforms we have.
>>>>> Both the 'mach-' and the '-dt' part of the file name are redundant.
>>>>>
>>>>> Alternatively, you could merge it all into common.c.
>>>>
>>>>
>>>> exynos.c sounds good to me.
>>>
>
> Well, let me see common.c and mach-exynos.c, one is for SoC specific
> stuff and the other is for Board specific so I think, keeping current
> file would be good, we can change the file name mach-exynos.c or
> board-exynos.c though.

There is no board specific stuff in mach-exynos/ with DT, so there is no 
need to keep those file separate, especially when stuff from common.c is 
constantly being (re)moved.

Also I'd rather stick to what other platforms use, which would be 
exynos.c (like tegra.c), as Arnd proposed.

Best regards,
Tomasz
