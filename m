From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 19 Oct 2017 11:13:27 -0500
Subject: [PATCH v3 6/7] arm64: topology: Enable ACPI/PPTT based CPU
 topology.
In-Reply-To: <20171019155622.GC18883@red-moon>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-7-jeremy.linton@arm.com>
 <20171019155622.GC18883@red-moon>
Message-ID: <6a9836f5-d31c-67fb-b2dd-bc0972ebb1c2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2017 10:56 AM, Lorenzo Pieralisi wrote:
> On Thu, Oct 12, 2017 at 02:48:55PM -0500, Jeremy Linton wrote:
>> Propagate the topology information from the PPTT tree to the
>> cpu_topology array. We can get the thread id, core_id and
>> cluster_id by assuming certain levels of the PPTT tree correspond
>> to those concepts. The package_id is flagged in the tree and can be
>> found by passing an arbitrary large level to setup_acpi_cpu_topology()
>> which terminates its search when it finds an ACPI node flagged
>> as the physical package. If the tree doesn't contain enough
>> levels to represent all of thread/core/cod/package then the package
>> id will be used for the missing levels.
>>
>> Since server/ACPI machines are more likely to be multisocket and NUMA,
> 
> I think this stuff is vague enough already so to start with I would drop
> patch 4 and 5 and stop assuming what machines are more likely to ship
> with ACPI than DT.
> 
> I am just saying, for the umpteenth time, that these levels have no
> architectural meaning _whatsoever_, level is a hierarchy concept
> with no architectural meaning attached.

?

Did anyone say anything about that? No, I think the only thing being 
guaranteed here is that the kernel's physical_id maps to an ACPI defined 
socket. Which seems to be the mindset of pretty much the entire !arm64 
community meaning they are optimizing their software and the kernel with 
that concept in mind.

Are you denying the existence of non-uniformity between threads running 
on different physical sockets?
