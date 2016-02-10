From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Feb 2016 10:36:01 +0000
Subject: [PATCH v10 01/21] ARM64: Move PMU register related defines to
 asm/pmu.h
In-Reply-To: <1453866709-20324-2-git-send-email-zhaoshenglong@huawei.com>
References: <1453866709-20324-1-git-send-email-zhaoshenglong@huawei.com>
 <1453866709-20324-2-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160210103600.GE1052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 11:51:29AM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> To use the ARMv8 PMU related register defines from the KVM code,
> we move the relevant definitions to asm/pmu.h header file.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/pmu.h   | 67 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/perf_event.c | 36 +----------------------
>  2 files changed, 68 insertions(+), 35 deletions(-)
>  create mode 100644 arch/arm64/include/asm/pmu.h
> 
> diff --git a/arch/arm64/include/asm/pmu.h b/arch/arm64/include/asm/pmu.h
> new file mode 100644
> index 0000000..4406184
> --- /dev/null
> +++ b/arch/arm64/include/asm/pmu.h

I think you can stick this in perf_event.h and avoid having a brand
new header.

> @@ -0,0 +1,67 @@
> +/*
> + * PMU support
> + *
> + * Copyright (C) 2012 ARM Limited
> + * Author: Will Deacon <will.deacon@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef __ASM_PMU_H
> +#define __ASM_PMU_H
> +
> +#define ARMV8_MAX_COUNTERS      32
> +#define ARMV8_COUNTER_MASK      (ARMV8_MAX_COUNTERS - 1)

[...]

> +/*
> + * Event filters for PMUv3
> + */
> +#define	ARMV8_EXCLUDE_EL1	(1 << 31)
> +#define	ARMV8_EXCLUDE_EL0	(1 << 30)
> +#define	ARMV8_INCLUDE_EL2	(1 << 27)

You should prefix these more specifically if they're going to be exposed
like this. Something like ARMV8_PMU_*.

Will
