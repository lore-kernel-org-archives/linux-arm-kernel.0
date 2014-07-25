From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 25 Jul 2014 18:32:14 +0800
Subject: [PATCH 04/19] ARM64 / ACPI: Introduce arch_fix_phys_package_id()
 for cpu topology
In-Reply-To: <20140724144327.GJ17528@sirena.org.uk>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-5-git-send-email-hanjun.guo@linaro.org>
 <20140724144327.GJ17528@sirena.org.uk>
Message-ID: <53D2322E.9010802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-7-24 22:43, Mark Brown wrote:
> On Thu, Jul 24, 2014 at 09:00:10PM +0800, Hanjun Guo wrote:
> 
>> +/*
>> + * Use the CPU slot number provided by ACPI to update the physical
>> + * package id when cpuid_topo->cluster_id is not available, then we
>> + * can get the right value in the "physical id" field of /proc/cpuinfo.
>> + */
>> +void arch_fix_phys_package_id(int num, u32 slot)
>> +{
>> +	struct cpu_topology *cpuid_topo = &cpu_topology[num];
>> +
>> +	if (cpuid_topo->cluster_id == -1)
>> +		cpuid_topo->cluster_id = slot;
>> +}
>> +EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);
> 
> As I said on the previous version of this patch are you sure this runs
> at a point between the cluster ID getting initialized to -1 and the slot
> being initialized (bear in mind that we now use MPIDR information if
> availabe).  I don't understand why we don't just unconditionally use the
> value given.

Ah, sorry, it should be unconditionally used as you said, and I remember
the comments in last version, but the patch shows not, must be something
wrong, will update it in next version.

Thanks
Hanjun
