From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 8 Jul 2016 16:21:51 +0100
Subject: [PATCH v8 5/6] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <20160708144719.GI3784@red-moon>
References: <1467911451-24731-1-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-2-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-3-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-4-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-5-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-6-git-send-email-sudeep.holla@arm.com>
 <20160708144719.GI3784@red-moon>
Message-ID: <577FC50F.7010205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/07/16 15:47, Lorenzo Pieralisi wrote:
> On Thu, Jul 07, 2016 at 06:10:50PM +0100, Sudeep Holla wrote:
>> This patch adds appropriate callbacks to support ACPI Low Power Idle
>> (LPI) on ARM64.
>>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm64/kernel/cpuidle.c |  18 +++++++
>>   drivers/firmware/psci.c     | 122 ++++++++++++++++++++++++++++++++++++--------
>
> I would split this patch in two (ARM64 cpuidle and PSCI)

Agreed, I combined it to get it functional in one go, but until we have
6/6, it won't work. So better to split that changes.

> and for
> the PSCI code (apologies, blame taken, it is entirely my fault) I
> think that the code in v6 was better, I asked you to factor out
> DT/ACPI idle states count and parameter retrieval but the end result
> is much more complicated than what it was in v6, so for PSCI ACPI
> idle states parsing I would revert to v6, apologies.
>

Yes I agree it got bit complicated. I will revert back to v6 for that part.


> With changes above:
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>

Thanks

-- 
Regards,
Sudeep
