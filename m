From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 12 Mar 2015 18:16:45 +0800
Subject: [PATCH v10 13/21] ACPI / processor: Introduce phys_cpuid_t for
 CPU hardware ID
In-Reply-To: <20150312095151.GB18414@red-moon>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-14-git-send-email-hanjun.guo@linaro.org>
 <20150312095151.GB18414@red-moon>
Message-ID: <5501678D.5090608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?03?12? 17:51, Lorenzo Pieralisi wrote:
> On Wed, Mar 11, 2015 at 12:39:39PM +0000, Hanjun Guo wrote:
>> CPU hardware ID (phys_id) is defined as u32 in structure acpi_processor,
>> but phys_id is used as int in acpi processor driver, so it will lead to
>> some inconsistence for the drivers.
>>
>> Furthermore, to cater for ACPI arch ports that implement 64 bits CPU
>> ids a generic CPU physical id type is required.
>>
>> So introduce typedef u32 phys_cpuid_t for x86 and ia64, and introduce
>> a macro CPU_PHYS_ID_INVALID as (u32)(-1), use phys_cpuid_t when phys_id
>> defined in acpi processor driver, and replace CPU_PHYS_ID_INVALID as -1
>> for phys_id, this will solve the inconsistence in acpi processor driver,
>> and will prepare for the ACPI on ARM64 for the 64 bit CPU hardware ID
>> in the following patch.
>
> Nit: Commit log above is stale (since you moved the phys_cpuid_t to
> common declaration for all archs that do not define PHYS_CPUID_INVALID
> and the macro name itself changed) so you should rewrite it before

Oops, I will send a updated patch only for this one, good catch.

> asking to merge it. Furthermore you should not describe how you implemented
> the change, you should describe why.

I'm prefer writing the commit log as following way (not always) :)
  - why the patch is needed
  - what the patch implements
  - How the patch is implemented

>
> Other than that:
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks!

Hanjun
