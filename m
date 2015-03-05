From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Mar 2015 11:27:08 +0000
Subject: [PATCH v9 14/21] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <54F80DC9.3090808@huawei.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-15-git-send-email-hanjun.guo@linaro.org>
 <2411054.s4TkmAUKjT@vostro.rjw.lan> <54F80DC9.3090808@huawei.com>
Message-ID: <20150305112707.GB7712@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 04:03:21PM +0800, Hanjun Guo wrote:
> On 2015/3/5 6:46, Rafael J. Wysocki wrote:
> > IMO, you really need to define phys_cpuid_t in a common place or people will
> > forget that it may be 64-bit, because they'll only be looking at their arch.
> 
> Since x86 and ARM64 are using different types for phys_cpuid_t, we need to
> introduce something like following if define it in common place:
> 
> in linux/acpi.h,
> 
> #if defined(CONFIG_X86) || defined(CONFIG_IA64)
> typedef u32 phys_cpuid_t;
> #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
> #else if defined(CONFIG_ARM64)
> typedef u64 phys_cpuid_t;
> #define PHYS_CPUID_INVALID INVALID_HWID
> #endif
> 
> I think it's awful, did I miss something?

I also think that's awful. I'm rather in favour of a per-arch
phys_cpuid_t.

-- 
Catalin
