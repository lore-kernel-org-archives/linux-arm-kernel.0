From: tn@semihalf.com (Tomasz Nowicki)
Date: Fri, 27 Oct 2017 07:21:13 +0200
Subject: [PATCH v3 1/7] ACPI/PPTT: Add Processor Properties Topology Table
 parsing
In-Reply-To: <49421fa9-c3ac-c81b-ed2d-a113f676edd8@huawei.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-2-jeremy.linton@arm.com>
 <38c63cfd-4c13-9461-0d4a-74b0943be0fd@semihalf.com>
 <2ce92b90-fc2c-3fff-a3e3-b9517057ab2c@arm.com>
 <4ee4af4d-d987-33f9-4d55-67bfede3ebfa@caviumnetworks.com>
 <ed7f2e82-1e9b-9f46-89af-4e638275355d@caviumnetworks.com>
 <47d8ef93-a3ce-6d40-f8db-2bc7d527ac6f@arm.com>
 <2605aa54-95f7-4619-e632-0a95a68e5fb0@caviumnetworks.com>
 <49421fa9-c3ac-c81b-ed2d-a113f676edd8@huawei.com>
Message-ID: <e4f9e8f1-c200-7350-79af-7f3e9e5c3106@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On 19.10.2017 12:25, John Garry wrote:
> On 19/10/2017 06:18, Tomasz Nowicki wrote:
>>>
>>> Summary:
>>>
>>> I'm not at all happy with this specification's attempt to leave out
>>> pieces of information which make parsing things more deterministic. In
>>> this case I'm happy to demote the message level, but not remove it
>>> entirely but I do think the obvious case you list shouldn't be the
>>> default one.
>>>
>>> Lastly:
>>>
>>> I'm assuming the final result is that the table is actually being
>>> parsed correctly despite the ugly message?
>>
>> Indeed, the ThunderX2 PPTT table is being parsed so that topology shown
>> in lstopo and lscpu is correct.
> 
> Hi Tomasz,
> 
> Can you share the lscpu output? Does it have cluster info? I did not 
> think that lscpu has a concept of clustering.
> 
> I would say that the per-cpu cluster index sysfs entry needs be added to 
> drivers/base/arch_topology.c (and other appropiate code under 
> GENERIC_ARCH_TOPOLOGY) to support this.

Here is what I get:

tn at val2-11 [~]$ lscpu -ap
# The following is the parsable format, which can be fed to other
# programs. Each different item in every column has an unique ID
# starting from zero.
# CPU,Core,Socket,Node,,L1d,L1i,L2,L3
[...]
1,0,0,0,,0,0,0,0
[...]

so yes, no cluster info.

Thanks,
Tomasz
