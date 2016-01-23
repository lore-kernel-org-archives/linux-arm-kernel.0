From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Sat, 23 Jan 2016 11:25:23 +0100
Subject: [PATCH v3 04/12] acpi, numa: introduce ACPI_HAS_NUMA_ARCH_FIXUP
In-Reply-To: <1453541967-3744-5-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-5-git-send-email-guohanjun@huawei.com>
Message-ID: <20160123102523.GC24726@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.01.16 17:39:19, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> acpi_numa_arch_fixup() is only used for IA64, x86 introduce a dummy
> function for it, when we came to a new architecture (such as ARM64),
> we need to introduce another dummy one to make the code compile.
> 
> That's pretty boring so introduce ACPI_HAS_NUMA_ARCH_FIXUP and
> select it for IA64, introduce a stub function for acpi_numa_arch_fixup()
> then it's pretty clean for x86 and ARM64.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/ia64/Kconfig    | 1 +

I see an implementation of acpi_numa_arch_fixup() only for ia64. Why
not move it to arch/ia64 then and call it from setup_arch() in
arch/ia64/kernel/setup.c after acpi_numa_init()? It looks like we
don't need a generic solution for this. This avoids any kconfig
handling for this at all.

-Robert
