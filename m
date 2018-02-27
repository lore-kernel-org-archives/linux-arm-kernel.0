From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 27 Feb 2018 12:49:58 -0600
Subject: [PATCH v7 00/13] Support PPTT for ARM64
In-Reply-To: <8b5bfd7e-57ea-bb34-85f8-69007a3847e6@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <8b5bfd7e-57ea-bb34-85f8-69007a3847e6@arm.com>
Message-ID: <1890b2e2-375e-f44f-c224-8cfa23a0add3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2018 06:06 AM, Sudeep Holla wrote:
> Hi Jeremy,
> 
> On 28/02/18 22:06, Jeremy Linton wrote:
>> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
>> used to describe the processor and cache topology. Ideally it is
>> used to extend/override information provided by the hardware, but
>> right now ARM64 is entirely dependent on firmware provided tables.
>>
>> This patch parses the table for the cache topology and CPU topology.
>> When we enable ACPI/PPTT for arm64 we map the physical_id to the
>> PPTT node flagged as the physical package by the firmware.
>> This results in topologies that match what the remainder of the
>> system expects. To avoid inverted scheduler domains we then
>> set the MC domain equal to the largest cache within the socket
>> below the NUMA domain.
>>
> I remember reviewing and acknowledging most of the cacheinfo stuff with
> couple of minor suggestions for v6. I don't see any Acked-by tags in
> this series and don't know if I need to review/ack any more cacheinfo
> related patches.

Hi,

Yes, I didn't put them in because I changed the functionality in 2/13 
and there is a bug fix in 5/13. I thought you might want to do a quick 
diff of the git v6->v7 tree.

Although given that most of the changes were in response to your 
comments in v6 I probably should have just put the tags in.


Thanks,
