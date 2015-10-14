From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 14 Oct 2015 10:03:51 +0100
Subject: [PATCH v3 24/24] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1
 to sysfs
In-Reply-To: <1444756952-31145-25-git-send-email-suzuki.poulose@arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
 <1444756952-31145-25-git-send-email-suzuki.poulose@arm.com>
Message-ID: <561E1A77.1060902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/15 18:22, Suzuki K. Poulose wrote:
> From: Steve Capper <steve.capper@linaro.org>
>
> It can be useful for JIT software to be aware of MIDR_EL1 and
> REVIDR_EL1 to ascertain the presence of any core errata that could
> affect codegen.
>
> This patch exposes these registers through sysfs:
>
> /sys/devices/system/cpu/cpu$ID/identification/midr
> /sys/devices/system/cpu/cpu$ID/identification/revidr
>
> where $ID is the cpu number. For big.LITTLE systems, one can have a
> mixture of cores (e.g. Cortex A53 and Cortex A57), thus all CPUs need
> to be enumerated.
>
> If the kernel does not have valid information to populate these entries
> with, an empty string is returned to userspace.
>

For the record:

> Signed-off-by: Steve Capper <steve.capper@linaro.org>
  [ Added error code for cpus !present in show_xxx_name ]
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>

Suzuki
