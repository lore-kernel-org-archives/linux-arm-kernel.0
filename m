From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 22 Jun 2016 17:09:53 +0100
Subject: [PATCH v6 3/5] arm64: cpuidle: drop __init section marker to
 arm_cpuidle_init
In-Reply-To: <1465915719-8409-4-git-send-email-sudeep.holla@arm.com>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-4-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160622160953.GA3976@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 03:48:37PM +0100, Sudeep Holla wrote:
> Commit ea389daa7fd9 ("arm64: cpuidle: add __init section marker to
> arm_cpuidle_init") added the __init annotation to arm_cpuidle_init
> as it was not needed after booting which was correct at that time.
> 
> However with the introduction of ACPI LPI support, this will be used
> from cpuhotplug path in ACPI processor driver.
> 
> This patch drops the __init annotation from arm_cpuidle_init to avoid
> the following warning:
> 
> WARNING: vmlinux.o(.text+0x113c8): Section mismatch in reference from the
> 	function acpi_processor_ffh_lpi_probe() to the function
> 	.init.text:arm_cpuidle_init()
> The function acpi_processor_ffh_lpi_probe() references
> the function __init arm_cpuidle_init().
> This is often because acpi_processor_ffh_lpi_probe lacks a __init
> annotation or the annotation of arm_cpuidle_init is wrong.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Depending on acceptance of other patches in this series:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> ---
>  arch/arm64/kernel/cpuidle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> index e11857fce05f..06786fdaadeb 100644
> --- a/arch/arm64/kernel/cpuidle.c
> +++ b/arch/arm64/kernel/cpuidle.c
> @@ -15,7 +15,7 @@
>  #include <asm/cpuidle.h>
>  #include <asm/cpu_ops.h>
>  
> -int __init arm_cpuidle_init(unsigned int cpu)
> +int arm_cpuidle_init(unsigned int cpu)
>  {
>  	int ret = -EOPNOTSUPP;
>  
> -- 
> 2.7.4
> 
