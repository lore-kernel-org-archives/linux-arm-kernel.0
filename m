From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 27 Jun 2016 17:08:30 +0200
Subject: [PATCH v6 5/5] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
In-Reply-To: <57714106.2040200@arm.com>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-6-git-send-email-sudeep.holla@arm.com>
 <5771392B.3080002@linaro.org> <57714043.5020207@arm.com>
 <577140A7.60904@linaro.org> <57714106.2040200@arm.com>
Message-ID: <5771416E.1040000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2016 05:06 PM, Sudeep Holla wrote:
>
>
> On 27/06/16 16:05, Daniel Lezcano wrote:
>> On 06/27/2016 05:03 PM, Sudeep Holla wrote:
>>> Hi Daniel,
>>>
>>> On 27/06/16 15:33, Daniel Lezcano wrote:
>>>> On 06/14/2016 04:48 PM, Sudeep Holla wrote:
>>>>> Now that ACPI processor idle driver supports LPI(Low Power Idle), lets
>>>>> enable ACPI_PROCESSOR_IDLE for ARM64 too.
>>>>>
>>>>> This patch just removes the IA64 and X86 dependency on
>>>>> ACPI_PROCESSOR_IDLE
>>>>>
>>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>>> ---
>>>>
>>>> Hi Sudeep,
>>>>
>>>> now that ACPI processor supports ARM64 did you check the
>>>> CPUIDLE_DRIVER_STATE_START trick in the code and its derivative ?
>>>>
>>>
>>> No, that is used only for C-State and ARM64 doesn't support it.
>>> Patch 1/5 puts all the C-State code under #ifdef so that it's not
>>> compiled on ARM64.
>>>
>>>> I deleted the patch 2/5 but there is a place where:
>>>>
>>>
>>> Sorry, I don't follow what you mean by that.
>>
>> I meant I just deleted from my mailbox the patch 2/5, so I can't do
>> inline comment.
>>
>
> Ah ok, anyways LPI always starts from index 0. IIUC that was your main
> concern.

Do you have a repo where I can see the code ?
