From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jan 2014 14:12:41 +0000
Subject: [PATCH 04/20] ARM64 / ACPI: Introduce arm_core.c and its related
 head file
In-Reply-To: <1389961514-13562-5-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-5-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140117141241.GH16003@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 12:24:58PM +0000, Hanjun Guo wrote:
> Introduce arm_core.c and its related head file, after this patch,
> we can get ACPI tables from firmware on ARM64 now.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

[...]

> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index bd9bbd0..2210353 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -41,6 +41,7 @@
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
> +#include <linux/acpi.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/elf.h>
> @@ -225,6 +226,11 @@ void __init setup_arch(char **cmdline_p)
>  
>  	arm64_memblock_init();
>  
> +	/* Parse the ACPI tables for possible boot-time configuration */
> +	acpi_boot_table_init();
> +	early_acpi_boot_init();
> +	acpi_boot_init();

Do we really need *three* back-to-back calls for ACPI to initialise?

Will
