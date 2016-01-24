From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sun, 24 Jan 2016 12:56:03 +0800
Subject: [PATCH v3 04/12] acpi, numa: introduce ACPI_HAS_NUMA_ARCH_FIXUP
In-Reply-To: <20160123102523.GC24726@rric.localdomain>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-5-git-send-email-guohanjun@huawei.com>
 <20160123102523.GC24726@rric.localdomain>
Message-ID: <56A45963.40105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2016 06:25 PM, Robert Richter wrote:
> On 23.01.16 17:39:19, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> acpi_numa_arch_fixup() is only used for IA64, x86 introduce a dummy
>> function for it, when we came to a new architecture (such as ARM64),
>> we need to introduce another dummy one to make the code compile.
>>
>> That's pretty boring so introduce ACPI_HAS_NUMA_ARCH_FIXUP and
>> select it for IA64, introduce a stub function for acpi_numa_arch_fixup()
>> then it's pretty clean for x86 and ARM64.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/ia64/Kconfig    | 1 +
>
> I see an implementation of acpi_numa_arch_fixup() only for ia64. Why
> not move it to arch/ia64 then and call it from setup_arch() in
> arch/ia64/kernel/setup.c after acpi_numa_init()? It looks like we
> don't need a generic solution for this. This avoids any kconfig
> handling for this at all.

It's much simpler as you suggested, I will update it in next
version, thank you Robert :)

Hanjun
