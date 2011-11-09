From: eric.miao@canonical.com (Eric Miao)
Date: Wed, 9 Nov 2011 20:19:46 +0800
Subject: [PATCH v2] ARM: arch.h: Declare 'pt_regs' locally
In-Reply-To: <1320840648-3197-1-git-send-email-fabio.estevam@freescale.com>
References: <1320840648-3197-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAMPhdO-gh9bpy55QYV6dscJm5=Gn=dr1H-qNptKUmjxFLDCpOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2011 at 8:10 PM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> Fix the following warning when building imx_v4_v5_defconfig target:
>
> ?CC ? ? ?arch/arm/mach-imx/mach-imx27ipcam.o
> In file included from arch/arm/mach-imx/mach-imx27ipcam.c:18:
> /home/fabio/linus/linux-2.6/arch/arm/include/asm/mach/arch.h:47: warning: 'struct pt_regs' declared inside parameter list
> /home/fabio/linus/linux-2.6/arch/arm/include/asm/mach/arch.h:47: warning: its scope is only this definition or declaration, which is probably not what you want
> arch/arm/mach-imx/mach-imx27ipcam.c:78: warning: initialization from incompatible pointer type
>
> Declare 'struct pt_regs' locally.
>
> Cc: Eric Miao <eric.miao@canonical.com>

Acked

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Define struct pt_regs locally instead of adding <asm/mach/irq.h>
> - Change the Subject accordingly
>
> ?arch/arm/include/asm/mach/arch.h | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 7d19425..2b0efc3 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -13,6 +13,7 @@
> ?struct tag;
> ?struct meminfo;
> ?struct sys_timer;
> +struct pt_regs;
>
> ?struct machine_desc {
> ? ? ? ?unsigned int ? ? ? ? ? ?nr; ? ? ? ? ? ? /* architecture number ?*/
> --
> 1.7.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
