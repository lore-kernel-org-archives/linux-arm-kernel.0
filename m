From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 27 Apr 2018 14:08:14 +0100
Subject: [PATCH v8 04/13] arm64/acpi: Create arch specific cpu to acpi id
 helper
In-Reply-To: <ee956bd3-37d7-b9ac-af55-dc297397476d@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-5-jeremy.linton@arm.com>
 <16324b54-42d4-d9bc-6d57-de52431dc209@arm.com>
 <ee956bd3-37d7-b9ac-af55-dc297397476d@arm.com>
Message-ID: <a00dd78c-6e94-26a2-1515-c677a032e6ce@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/04/18 19:33, Jeremy Linton wrote:
> Hi,
> 
> On 04/26/2018 05:27 AM, Sudeep Holla wrote:
>>
>>
>> On 26/04/18 00:31, Jeremy Linton wrote:
>>> Its helpful to be able to lookup the acpi_processor_id associated
>>> with a logical cpu. Provide an arm64 helper to do this.
>>>
>>
>> As I pointed out in the earlier version, this patch is not required.
>> The acpi_id stored in the acpi_processor can be used for this.
>> Won't the below change make it work ? I can't think of any reason why it
>> shouldn't.
> 
> So, I only noticed your previous email last night on the mail archive,
> as I was applying your review/ack tags and couldn't find a response for
> this patch, seem the spam/etc filters need some further tweaking!
>

Ah that's bad.

> At that point, I was pretty sure the suggestion wasn't going to work out
> of the box as a lot of this code is running fairly early in the boot
> process. I spent a bit of time and plugged the change in to verify that
> assertion, and yes the per_cpu processor/acpi bits aren't setup early
> enough to be used by much of this code. It is being called from
> init_cpu_topology()/smp_prepare_cpus() which precedes
> do_basic_setup/do_initcalls() which is what runs the acpi_init()
> sequence which ends up eventually allocating the required data
> structures. So without restructuring the core boot sequence, this seems
> like a reasonable solution.
> 

OK makes sense. I completely ignored topology related patches as I
haven't looked at them yet and assumed cacheinfo is the only user. Sorry
for that.

-- 
Regards,
Sudeep
