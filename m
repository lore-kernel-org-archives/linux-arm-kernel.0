From: olof@lixom.net (Olof Johansson)
Date: Wed, 10 Oct 2012 09:08:39 -0700
Subject: [PATCH 6/6] ARM: EXYNOS: Add secure firmware support to
 secondary CPU bring-up
In-Reply-To: <1348496913-25422-7-git-send-email-t.figa@samsung.com>
References: <1348496913-25422-1-git-send-email-t.figa@samsung.com>
 <1348496913-25422-7-git-send-email-t.figa@samsung.com>
Message-ID: <20121010160839.GB582@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 04:28:33PM +0200, Tomasz Figa wrote:
> Boards using secure firmware must use different CPU boot registers and
> call secure firmware to boot the CPU.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index a7f4031..4a18250 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -25,6 +25,7 @@
>  #include <asm/hardware/gic.h>
>  #include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
> +#include <asm/firmware.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/regs-clock.h>
> @@ -44,6 +45,8 @@ static inline void __iomem *cpu_boot_reg_base(void)
>  static inline void __iomem *cpu_boot_reg(int cpu)
>  {
>  	void __iomem *boot_reg;
> +	if (!call_firmware_op(cpu_boot_reg, cpu, &boot_reg))
> +		return boot_reg;

Nit: new lines between variable declaration and code.


-Olof
