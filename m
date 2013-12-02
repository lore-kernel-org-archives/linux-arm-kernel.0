From: zhangfei.gao@gmail.com (Zhangfei Gao)
Date: Mon, 2 Dec 2013 14:42:23 +0800
Subject: Build warning in drivers/dma/mmp_tdma.c
In-Reply-To: <CAPcyv4i1i+3ia5qcYA-LR4TFq1MOCXTHLhW2u5maq6Us9kyATg@mail.gmail.com>
References: <CAPcyv4i1i+3ia5qcYA-LR4TFq1MOCXTHLhW2u5maq6Us9kyATg@mail.gmail.com>
Message-ID: <CAMj5Bkjk6v_2Op1oph8GGw2mf8w40c-L3JhBRPNsRewiFxQHpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Dan

On Fri, Nov 29, 2013 at 6:58 AM, Dan Williams <dan.j.williams@intel.com> wrote:

> I'm also carrying patch to add a missing dependency:
>
> commit 1a4ee91dacedde3e82d8ce6eeace7f16884474f9
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Thu Nov 28 12:27:38 2013 -0800
>
>     dma: mmp_dma depends on CPU_MMP2
>
>     It calls sram_get_gpool() which is only defined if CONFIG_CPU_MMP2=y
>
>     Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 446687cc2334..dad83634cb65 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -287,7 +287,7 @@ config DMA_SA11X0
>
>  config MMP_TDMA
>         bool "MMP Two-Channel DMA support"
> -       depends on ARCH_MMP
> +       depends on ARCH_MMP && CPU_MMP2

Hi, Qiao

Do you have comments?
Does this work on PXA910?

Does sram also use on pxa910?
arch/arm/mach-mmp/Makefile
obj-$(CONFIG_CPU_MMP2)          += mmp2.o sram.o

Zhangfei
