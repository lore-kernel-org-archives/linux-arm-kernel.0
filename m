From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Aug 2014 15:38:17 +0100
Subject: [PATCH v2 06/18] ARM64 / ACPI: Parse MADT to map logical cpu to
 MPIDR and get cpu_possible/present_map
In-Reply-To: <53F2FE8E.60307@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-7-git-send-email-hanjun.guo@linaro.org>
 <20140818142728.GS20043@localhost> <53F2FE8E.60307@linaro.org>
Message-ID: <20140820143817.GN24600@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 08:36:46AM +0100, Hanjun Guo wrote:
> On 2014-8-18 22:27, Catalin Marinas wrote:
> > On Mon, Aug 04, 2014 at 04:28:13PM +0100, Hanjun Guo wrote:
> >> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> >> index 6e04868..e877967 100644
> >> --- a/arch/arm64/include/asm/acpi.h
> >> +++ b/arch/arm64/include/asm/acpi.h
> >> @@ -64,6 +64,8 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> >>  extern int (*acpi_suspend_lowlevel)(void);
> >>  #define acpi_wakeup_address 0
> >>  
> >> +#define MAX_GIC_CPU_INTERFACE 65535
> > 
> > Does this need to be more than NR_CPUS?
> 
> Sometimes yes, CPU structure entries in MADT just like CPU nodes in
> device tree, the number of them may more than NR_CPUS.

I have a more general question here. In ACPI, is MADT the only way to
build a CPU topology? It looks weird that we use GIC properties to
create the cpu_logical_map(). A side-effect is that the GIC-related
functions are now scattered all over the kernel rather than being
contained in the GIC driver itself.

-- 
Catalin
