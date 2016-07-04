From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 4 Jul 2016 14:00:03 +0100
Subject: [PATCH v7 2/6] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
In-Reply-To: <57766B15.4090407@linaro.org>
References: <1467122152-5604-1-git-send-email-sudeep.holla@arm.com>
 <1467122152-5604-3-git-send-email-sudeep.holla@arm.com>
 <57766B15.4090407@linaro.org>
Message-ID: <577A5DD3.4050901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/07/16 14:07, Daniel Lezcano wrote:
> On 06/28/2016 03:55 PM, Sudeep Holla wrote:
>> ACPI 6.0 introduced an optional object _LPI that provides an alternate
>> method to describe Low Power Idle states. It defines the local power
>> states for each node in a hierarchical processor topology. The OSPM can
>> use _LPI object to select a local power state for each level of processor
>> hierarchy in the system. They used to produce a composite power state
>> request that is presented to the platform by the OSPM.
>>
>> Since multiple processors affect the idle state for any non-leaf
>> hierarchy
>> node, coordination of idle state requests between the processors is
>> required. ACPI supports two different coordination schemes: Platform
>> coordinated and  OS initiated.
>>
>> This patch adds initial support for Platform coordination scheme of LPI.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>
> Hi Sudeep,
>
> I looked at the acpi processor idle code sometime ago and from my POV,
> it was awful, unnecessary complex and very difficult to maintain. The
> usage of flags all over the places is significant of the lack of control
> of the written code.
>

So you have any specific things in mind ? That's too broad and I know
it's not so clean, but it's so for legacy reasons. I would leave that
to Rafael to decide as it takes lots of testing to clean up these code.

> Even if you are not responsible of this implementation, the current
> situation forces you to add more awful code on top of that, which is
> clearly against "making Linux better".
>

OK

> IMO, the current code deserves a huge cleanup before applying anything
> new : cstate and lpi should be investigated to be self-contained in
> their respective file and consolidated, the global variable usage should
> be killed, redundant flag checking removed by recapturing the code flow,
> etc ... I believe the usage of acpi probe table could be one entry point
> to begin this cleanup.
>

This is not a static table.

-- 
Regards,
Sudeep
