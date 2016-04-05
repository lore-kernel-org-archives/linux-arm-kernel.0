From: david@lechnology.com (David Lechner)
Date: Tue, 5 Apr 2016 12:11:23 -0500
Subject: [PATCH v3 0/5] davinci_mmc fixes
In-Reply-To: <5703F0DF.3020209@lechnology.com>
References: <1458186341-6970-1-git-send-email-david@lechnology.com>
 <CAPDyKFp3UELfw2gNTh0GeX31bjwb8tbDiua6ZigLwhaUkcv3zA@mail.gmail.com>
 <5703ECFE.6060706@lechnology.com> <5703F0DF.3020209@lechnology.com>
Message-ID: <5703F1BB.1090401@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2016 12:07 PM, David Lechner wrote:
> On 04/05/2016 11:51 AM, David Lechner wrote:
>> On 04/05/2016 06:12 AM, Ulf Hansson wrote:
>>>
>>> Patch 3 triggers a compiler warning, please fix it.
>>>
>>> ../drivers/mmc/host/davinci_mmc.c: In function ?davinci_mmcsd_probe?:
>>> ../drivers/mmc/host/davinci_mmc.c:1208:6: warning: ?ret? may be used
>>> uninitialized in this function [-Wmaybe-uninitialized]
>>>
>>> I have applied patch 1->2 for next, so no need to resend these.
>>>
>>> Kind regards
>>> Uffe
>>>
>>
>> I am not getting a compiler warning with this commit. Can you please
>> provide a git link so that I can be sure I am building using the same
>> branch that you are using?
>
>
> I think I figured it out. I am applying the patches on top of the next
> branch from git://git.linaro.org/people/ulf.hansson/mmc.git. However, I
> am still not getting a compiler warning. Perhaps it has to do with the
> gcc version. I'm not exactly sure how to fix it since it is really not
> used uninitialized. Just set it to 0 in the variable declaration?

OK. I guess it is my compiler that is broken. :-/
I stared at it long enough and I see the error now.
