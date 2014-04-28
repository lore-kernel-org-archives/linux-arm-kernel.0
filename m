From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 28 Apr 2014 14:23:08 +0200
Subject: [PATCH v8 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <CAJ5Y-eYFz0CQU4jWOnmiFNRJ+Q=12pvyTf72w7MUk3ebY75wgg@mail.gmail.com>
References: <1398455329-18136-1-git-send-email-ashwin.chaugule@linaro.org>
 <1398455329-18136-4-git-send-email-ashwin.chaugule@linaro.org>
 <CALrVBkuV2kQmBScDSMUVG+hOMZ3FQ1tEOEwUEPHRoCo9si+ygA@mail.gmail.com>
 <CAJ5Y-eYFz0CQU4jWOnmiFNRJ+Q=12pvyTf72w7MUk3ebY75wgg@mail.gmail.com>
Message-ID: <CAMJs5B9d+=kfJ=rnf=_9ywmjtXK4v=OQeVcDu53j0J89GWzfpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2014 14:16, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> Hello,
>
> On 28 April 2014 02:18, Anup Patel <anup.patel@linaro.org> wrote:
>>> --- a/include/uapi/linux/psci.h
>>> +++ b/include/uapi/linux/psci.h
>>> @@ -74,4 +74,9 @@
>>>  #define PSCI_RET_NOT_PRESENT                   -7
>>>  #define PSCI_RET_DISABLED                      -8
>>>
>>> +/* Return values from the PSCI_ID_AFFINITY_INFO Function. */
>>> +#define PSCI_AFFINITY_INFO_RET_ON                      0
>>> +#define PSCI_AFFINITY_INFO_RET_OFF                     1
>>> +#define PSCI_AFFINITY_INFO_RET_ON_PENDING      2
>>
>> I have already added this return values in v10 patchset for PSCI v0.2
>> emulation for KVM ARM/ARM64.
>> (http://www.spinics.net/lists/kvm-arm/msg09062.html)
>>
>> Please rebase your patch against that.
>
>
> Ok will do.
>
> Whats the merge plan for these patches? We both share a common header
> but the code that uses it would seemingly go up via different trees.
> armv8 (Catalin) and KVM (Christoffer)?
>
Are they inter-dependent?  I thought your patches depended on Anup's -
not the other way around?

If my assumption is correct, I think we can make sure to send the pull
request to kvm/next early and ask Catalin to pull in kvm/next before
pulling your changes.

I'm cc'ing both Catalin and Paolo here for their advice.

Thanks,
-Christoffer
