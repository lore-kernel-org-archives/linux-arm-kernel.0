From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Mon, 24 Aug 2015 15:58:40 -0400
Subject: [PATCH 17/18] ARM: zynq: use const and __initconst for
 smp_operations
In-Reply-To: <1440390978-22796-18-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
 <1440390978-22796-18-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAAtXAHcAVxcCdkh-ne9W=2vORwi6o3WH6-yADn7mtgM4aaGpxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Moritz Fischer <moritz.fischer@ettus.com>

Thanks,

Moritz

On Mon, Aug 24, 2015 at 12:36 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The smp_operations structure is not over-written, so add const
> qualifier and replace __initdata with __initconst.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/mach-zynq/common.h  | 2 +-
>  arch/arm/mach-zynq/platsmp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
> index 79cda2e..e771933 100644
> --- a/arch/arm/mach-zynq/common.h
> +++ b/arch/arm/mach-zynq/common.h
> @@ -30,7 +30,7 @@ extern char zynq_secondary_trampoline;
>  extern char zynq_secondary_trampoline_jump;
>  extern char zynq_secondary_trampoline_end;
>  extern int zynq_cpun_start(u32 address, int cpu);
> -extern struct smp_operations zynq_smp_ops __initdata;
> +extern const struct smp_operations zynq_smp_ops;
>  #endif
>
>  extern void __iomem *zynq_scu_base;
> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
> index f66816c..7cd9865 100644
> --- a/arch/arm/mach-zynq/platsmp.c
> +++ b/arch/arm/mach-zynq/platsmp.c
> @@ -157,7 +157,7 @@ static void zynq_cpu_die(unsigned int cpu)
>  }
>  #endif
>
> -struct smp_operations zynq_smp_ops __initdata = {
> +const struct smp_operations zynq_smp_ops __initconst = {
>         .smp_init_cpus          = zynq_smp_init_cpus,
>         .smp_prepare_cpus       = zynq_smp_prepare_cpus,
>         .smp_boot_secondary     = zynq_boot_secondary,
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
