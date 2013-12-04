From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 04 Dec 2013 22:30:06 +0800
Subject: [RFC part1 PATCH 4/7] ARM64 / ACPI: Introduce the skeleton of
 _PDC related for ARM64
In-Reply-To: <CAL_JsqKmKsZtYgFrLBU+vOnHkC6x5nB9WfhM7hC=DipzEj8qhg@mail.gmail.com>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-5-git-send-email-hanjun.guo@linaro.org>
 <CAL_JsqKmKsZtYgFrLBU+vOnHkC6x5nB9WfhM7hC=DipzEj8qhg@mail.gmail.com>
Message-ID: <529F3C6E.5080802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?04? 01:12, Rob Herring wrote:
> On Tue, Dec 3, 2013 at 10:36 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
[...]
> +#ifndef _ASM_ARM_ACPI_H
> +#define _ASM_ARM_ACPI_H
> +
> +static inline bool arch_has_acpi_pdc(void)
> +{
> +       return false;   /* always false for now */
> +}
> +
> +static inline void arch_acpi_set_pdc_bits(u32 *buf)
> +{
> +       return;
> +}
> +
> +#endif /*_ASM_ARM_ACPI_H*/
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 45b20cd..73b1d3a 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -162,6 +162,17 @@ static inline void spin_lock_prefetch(const void *x)
>
>   #define HAVE_ARCH_PICK_MMAP_LAYOUT
>
> +#ifdef CONFIG_ACPI
> The ifdef is not necessary.

Good catch, will fix it in next version.

Thanks for the comments.

Hanjun
