From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 24 May 2010 14:41:02 +0800
Subject: [PATCH 3/6] [ARM] pxa: reserve more irq for board
In-Reply-To: <AANLkTinoQ9IU_gaJPI2nPl8mXLu3Ss_qMc8bP-gM4Ahh@mail.gmail.com>
References: <AANLkTinoQ9IU_gaJPI2nPl8mXLu3Ss_qMc8bP-gM4Ahh@mail.gmail.com>
Message-ID: <AANLkTinN9OiJIVc5Y2s4ET5-aERcBQLi_ZCh-VFHw9nO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 7:19 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From ab34824f36731dc1b1c49e1daa18abd0137c9c0e Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Fri, 12 Mar 2010 12:26:03 -0500
> Subject: [PATCH] [ARM] pxa: reserve more irq for board
>
> By default, only 16 IRQs are reserved for board IRQ. While genirq is used,
> more board IRQs should be reserved. Now update the default BOARD IRQs to 64.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Haojian,

Please see my irq_cleanup branch for reserving board IRQs, basically
a macro can be assigned to .nr_irqs in the machine_desc structure.
That branch is target for next merge window.

> ---
> ?arch/arm/mach-pxa/include/mach/irqs.h | ? ?6 +-----
> ?1 files changed, 1 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/irqs.h
> b/arch/arm/mach-pxa/include/mach/irqs.h
> index ffc8314..010c205 100644
> --- a/arch/arm/mach-pxa/include/mach/irqs.h
> +++ b/arch/arm/mach-pxa/include/mach/irqs.h
> @@ -127,12 +127,8 @@
>
> ?#if defined(CONFIG_MACH_H4700)
> ?#define IRQ_BOARD_END ? ? ? ? ?(IRQ_BOARD_START + 70)
> -#elif defined(CONFIG_MACH_ZYLONITE)
> -#define IRQ_BOARD_END ? ? ? ? ?(IRQ_BOARD_START + 32)
> -#elif defined(CONFIG_PXA_EZX)
> -#define IRQ_BOARD_END ? ? ? ? ?(IRQ_BOARD_START + 23)
> ?#else
> -#define IRQ_BOARD_END ? ? ? ? ?(IRQ_BOARD_START + 16)
> +#define IRQ_BOARD_END ? ? ? ? ?(IRQ_BOARD_START + 64)
> ?#endif
>
> ?/*
> --
> 1.5.6.5
>
