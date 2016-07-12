From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Jul 2016 16:23:19 +0100
Subject: [PATCH v9 3/7] arm64: cpuidle: drop __init section marker to
 arm_cpuidle_init
In-Reply-To: <1467997678-7107-4-git-send-email-sudeep.holla@arm.com>
References: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
 <1467997678-7107-4-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160712152319.GG22183@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 06:07:54PM +0100, Sudeep Holla wrote:
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
> Cc: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
