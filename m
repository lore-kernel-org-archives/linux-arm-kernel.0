From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 27 Jun 2016 16:03:31 +0100
Subject: [PATCH v6 5/5] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
In-Reply-To: <5771392B.3080002@linaro.org>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-6-git-send-email-sudeep.holla@arm.com>
 <5771392B.3080002@linaro.org>
Message-ID: <57714043.5020207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 27/06/16 15:33, Daniel Lezcano wrote:
> On 06/14/2016 04:48 PM, Sudeep Holla wrote:
>> Now that ACPI processor idle driver supports LPI(Low Power Idle), lets
>> enable ACPI_PROCESSOR_IDLE for ARM64 too.
>>
>> This patch just removes the IA64 and X86 dependency on
>> ACPI_PROCESSOR_IDLE
>>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>
> Hi Sudeep,
>
> now that ACPI processor supports ARM64 did you check the
> CPUIDLE_DRIVER_STATE_START trick in the code and its derivative ?
>

No, that is used only for C-State and ARM64 doesn't support it.
Patch 1/5 puts all the C-State code under #ifdef so that it's not
compiled on ARM64.

> I deleted the patch 2/5 but there is a place where:
>

Sorry, I don't follow what you mean by that.

> if (max_cstate=0)
>      max_cstate=1;
>
> Probably this is because the POLL state is inserted, so there is always
> an idle state. But for ARM, that is not the case.
>

Yes

> Also, there are some places where the idle state index begins to 1. I
> think it should be 0 for ARM.
>

Yes for LPI, it does start from 0.

-- 
Regards,
Sudeep
