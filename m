From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jul 2011 15:46:12 +0800
Subject: [PATCH] pxa/magician: fix MAGICIAN_EGPIO_BASE,
	align with NR_BUILTIN_GPIO
In-Reply-To: <1303394226.16309.1.camel@flow>
References: <1303394226.16309.1.camel@flow>
Message-ID: <CAMPhdO-xQ614Rs-tTEY0v7i6_Q=aNUtoCo3AZ33nc1LsKoTn4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 9:57 PM, Philipp Zabel <pzabel@gmx.de> wrote:
> Commit a0a4dcbca73a418477f439e812193e2591b46751
> "ARM: pxa: align NR_BUILTIN_GPIO with GPIO interrupt number"
> increased NR_BUILTIN_GPIO from 128 to PXA_GPIO_IRQ_NUM (192).
> Adjust the previously hardcoded MAGICIAN_EGPIO_BASE accordingly.
>
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/include/mach/magician.h | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
> index 0a2efcf..e9e6162 100644
> --- a/arch/arm/mach-pxa/include/mach/magician.h
> +++ b/arch/arm/mach-pxa/include/mach/magician.h
> @@ -12,6 +12,7 @@
> ?#ifndef _MAGICIAN_H_
> ?#define _MAGICIAN_H_
>
> +#include <mach/gpio.h>
> ?#include <mach/irqs.h>
>
> ?/*
> @@ -77,7 +78,7 @@
> ?* CPLD EGPIOs
> ?*/
>
> -#define MAGICIAN_EGPIO_BASE ? ? ? ? ? ? ? ? ? ?0x80 /* GPIO_BOARD_START */
> +#define MAGICIAN_EGPIO_BASE ? ? ? ? ? ? ? ? ? ?NR_BUILTIN_GPIO
> ?#define MAGICIAN_EGPIO(reg,bit) \
> ? ? ? ?(MAGICIAN_EGPIO_BASE + 8*reg + bit)
>
> --
> 1.7.4.4
>
>
>
