From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Jul 2016 12:08:28 +0100
Subject: [PATCH v9] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <1467990073-27462-1-git-send-email-suzuki.poulose@arm.com>
References: <1467990073-27462-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160712110827.GB18408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 04:01:13PM +0100, Suzuki K Poulose wrote:
> From: Steve Capper <steve.capper@linaro.org>
> 
> It can be useful for JIT software to be aware of MIDR_EL1 and
> REVIDR_EL1 to ascertain the presence of any core errata that could
> affect code generation.
> 
> This patch exposes these registers through sysfs:
> 
> /sys/devices/system/cpu/cpu$ID/regs/identification/midr_el1
> /sys/devices/system/cpu/cpu$ID/regs/identification/revidr_el1
> 
> where $ID is the cpu number. For big.LITTLE systems, one can have a
> mixture of cores (e.g. Cortex A53 and Cortex A57), thus all CPUs need
> to be enumerated.
> 
> If the kernel does not have valid information to populate these entries
> with, an empty string is returned to userspace.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> [ ABI documentation updates, hotplug notifiers, kobject changes ]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Looks good to me, thanks for sticking with it:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
