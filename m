From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 2 May 2018 17:35:50 -0500
Subject: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU
 topology
In-Reply-To: <CAJZ5v0jwtSkw1x+MQVYo60YDeW0+jxLy2d4spQOu+i=pY7fjyQ@mail.gmail.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-12-jeremy.linton@arm.com>
 <ab8357f0-61d5-2996-46ca-5bc5d3e097cf@arm.com>
 <CAJZ5v0jwtSkw1x+MQVYo60YDeW0+jxLy2d4spQOu+i=pY7fjyQ@mail.gmail.com>
Message-ID: <5078f4ac-74e7-aad3-1e0d-4de5da31d3c4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/02/2018 03:24 AM, Rafael J. Wysocki wrote:
> On Tue, May 1, 2018 at 4:46 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 26/04/18 00:31, Jeremy Linton wrote:
>>> Propagate the topology information from the PPTT tree to the
>>> cpu_topology array. We can get the thread id and core_id by assuming
>>> certain levels of the PPTT tree correspond to those concepts.
>>> The package_id is flagged in the tree and can be found by calling
>>> find_acpi_cpu_topology_package() which terminates
>>> its search when it finds an ACPI node flagged as the physical
>>> package. If the tree doesn't contain enough levels to represent
>>> all of the requested levels then the root node will be returned
>>> for all subsequent levels.
>>>
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> [..]
>>
>>> @@ -304,6 +345,8 @@ void __init init_cpu_topology(void)
>>>         * Discard anything that was parsed if we hit an error so we
>>>         * don't use partial information.
>>>         */
>>> -     if (of_have_populated_dt() && parse_dt_topology())
>>> +     if ((!acpi_disabled) && parse_acpi_topology())
>>
>> [nit] not sure if extra () is need above,
> 
> No, it isn't.
> 
>> but I am fine either way.
> 
> The redundant parens need to go away, really.
> 

Yah, I missed this one, is there a linter everyone is using that finds 
these?

Thanks,
