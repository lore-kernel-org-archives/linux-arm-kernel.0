From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 28 Apr 2014 08:16:13 -0400
Subject: [PATCH v8 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <CALrVBkuV2kQmBScDSMUVG+hOMZ3FQ1tEOEwUEPHRoCo9si+ygA@mail.gmail.com>
References: <1398455329-18136-1-git-send-email-ashwin.chaugule@linaro.org>
 <1398455329-18136-4-git-send-email-ashwin.chaugule@linaro.org>
 <CALrVBkuV2kQmBScDSMUVG+hOMZ3FQ1tEOEwUEPHRoCo9si+ygA@mail.gmail.com>
Message-ID: <CAJ5Y-eYFz0CQU4jWOnmiFNRJ+Q=12pvyTf72w7MUk3ebY75wgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 28 April 2014 02:18, Anup Patel <anup.patel@linaro.org> wrote:
>> --- a/include/uapi/linux/psci.h
>> +++ b/include/uapi/linux/psci.h
>> @@ -74,4 +74,9 @@
>>  #define PSCI_RET_NOT_PRESENT                   -7
>>  #define PSCI_RET_DISABLED                      -8
>>
>> +/* Return values from the PSCI_ID_AFFINITY_INFO Function. */
>> +#define PSCI_AFFINITY_INFO_RET_ON                      0
>> +#define PSCI_AFFINITY_INFO_RET_OFF                     1
>> +#define PSCI_AFFINITY_INFO_RET_ON_PENDING      2
>
> I have already added this return values in v10 patchset for PSCI v0.2
> emulation for KVM ARM/ARM64.
> (http://www.spinics.net/lists/kvm-arm/msg09062.html)
>
> Please rebase your patch against that.


Ok will do.

Whats the merge plan for these patches? We both share a common header
but the code that uses it would seemingly go up via different trees.
armv8 (Catalin) and KVM (Christoffer)?


Cheers,
Ashwin
