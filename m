From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 01 Apr 2014 14:29:28 +0200
Subject: exynos4: cpu hotplug + cpuidle/AFTR broken
In-Reply-To: <533AAE34.20601@linaro.org>
References: <533A9849.1080402@linaro.org> <533AA17A.1090405@samsung.com>
 <533AAE34.20601@linaro.org>
Message-ID: <533AB128.7050208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01.04.2014 14:16, Daniel Lezcano wrote:
> On 04/01/2014 01:22 PM, Tomasz Figa wrote:
>> Hi Daniel,
>>
>> On 01.04.2014 12:43, Daniel Lezcano wrote:
>>>
>>> Hi all,
>>>
>>> I tried the v3.14 kernel and unplugged the cpu1. That leads to a kernel
>>> hang without any trace.
>>>
>>> If I disable the cpuidle AFTR state through sysfs before unplugging
>>> cpu1, it works well.
>>>
>>> I reproduced the issue on v3.14, v3.13, v3.12, v3.11
>>>
>>> v3.10 works fine.
>>
>> Could you try to reproduce the same issue on linux-next? Some of PM
>> issues on Exynos should be patches there.
>
> Tested on linux-next. Works fine.

Great, thanks.

>
> Do you have an idea of the patch which have fixed the issue ? In order
> to backport it the kernels mentioned above.

Most likely it's this one:

61557b8bac ARM: EXYNOS: Do not resume l2x0 if not enabled before suspend

Best regards,
Tomasz
