From: mcuos.com@gmail.com (Wan ZongShun)
Date: Mon, 21 Nov 2011 11:56:04 +0800
Subject: [PATCH] ARM: w90x900: add common nuc9xx.h
In-Reply-To: <E1RRUQa-0005MI-5C@rmk-PC.arm.linux.org.uk>
References: <E1RRUQa-0005MI-5C@rmk-PC.arm.linux.org.uk>
Message-ID: <CAKT61h9v8uVBF3orXOESq8piajzxY4VXCQ7Ox8g96dndGUwoXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> Rather than having separate extern declarations in nuc9*.h, provide
> a common header file containing these definitions.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by :Wan Zongshun <mcuos.com@gmail.com>

> ---
> This is a preparatory patch for fixing w90x900 for the restart changes,
> and is the last patch which is currently in linux-next without any
> appropriate acks.
>
> ?arch/arm/mach-w90x900/irq.c ? ?| ? ?2 ++
> ?arch/arm/mach-w90x900/nuc910.h | ? ?9 +--------
> ?arch/arm/mach-w90x900/nuc950.h | ? ?9 +--------
> ?arch/arm/mach-w90x900/nuc960.h | ? ?9 +--------
> ?arch/arm/mach-w90x900/nuc9xx.h | ? 23 +++++++++++++++++++++++
> ?arch/arm/mach-w90x900/time.c ? | ? ?2 ++
> ?6 files changed, 30 insertions(+), 24 deletions(-)
> ?create mode 100644 arch/arm/mach-w90x900/nuc9xx.h
>
> diff --git a/arch/arm/mach-w90x900/irq.c b/arch/arm/mach-w90x900/irq.c
> index 7bf143c..b466e24 100644
> --- a/arch/arm/mach-w90x900/irq.c
> +++ b/arch/arm/mach-w90x900/irq.c
> @@ -28,6 +28,8 @@
> ?#include <mach/hardware.h>
> ?#include <mach/regs-irq.h>
>
> +#include "nuc9xx.h"
> +
> ?struct group_irq {
> ? ? ? ?unsigned long ? ? ? ? ? gpen;
> ? ? ? ?unsigned int ? ? ? ? ? ?enabled;
> diff --git a/arch/arm/mach-w90x900/nuc910.h b/arch/arm/mach-w90x900/nuc910.h
> index 83e9ba5..b14c71a 100644
> --- a/arch/arm/mach-w90x900/nuc910.h
> +++ b/arch/arm/mach-w90x900/nuc910.h
> @@ -12,14 +12,7 @@
> ?* published by the Free Software Foundation.
> ?*
> ?*/
> -
> -struct map_desc;
> -struct sys_timer;
> -
> -/* core initialisation functions */
> -
> -extern void nuc900_init_irq(void);
> -extern struct sys_timer nuc900_timer;
> +#include "nuc9xx.h"
>
> ?/* extern file from nuc910.c */
>
> diff --git a/arch/arm/mach-w90x900/nuc950.h b/arch/arm/mach-w90x900/nuc950.h
> index 98a1148..6e9de30 100644
> --- a/arch/arm/mach-w90x900/nuc950.h
> +++ b/arch/arm/mach-w90x900/nuc950.h
> @@ -12,14 +12,7 @@
> ?* published by the Free Software Foundation.
> ?*
> ?*/
> -
> -struct map_desc;
> -struct sys_timer;
> -
> -/* core initialisation functions */
> -
> -extern void nuc900_init_irq(void);
> -extern struct sys_timer nuc900_timer;
> +#include "nuc9xx.h"
>
> ?/* extern file from nuc950.c */
>
> diff --git a/arch/arm/mach-w90x900/nuc960.h b/arch/arm/mach-w90x900/nuc960.h
> index f0c07cb..9f6df9a 100644
> --- a/arch/arm/mach-w90x900/nuc960.h
> +++ b/arch/arm/mach-w90x900/nuc960.h
> @@ -12,14 +12,7 @@
> ?* published by the Free Software Foundation.
> ?*
> ?*/
> -
> -struct map_desc;
> -struct sys_timer;
> -
> -/* core initialisation functions */
> -
> -extern void nuc900_init_irq(void);
> -extern struct sys_timer nuc900_timer;
> +#include "nuc9xx.h"
>
> ?/* extern file from nuc960.c */
>
> diff --git a/arch/arm/mach-w90x900/nuc9xx.h b/arch/arm/mach-w90x900/nuc9xx.h
> new file mode 100644
> index 0000000..847c4f3
> --- /dev/null
> +++ b/arch/arm/mach-w90x900/nuc9xx.h
> @@ -0,0 +1,23 @@
> +/*
> + * arch/arm/mach-w90x900/nuc9xx.h
> + *
> + * Copied from nuc910.h, which had:
> + *
> + * Copyright (c) 2008 Nuvoton corporation
> + *
> + * Header file for NUC900 CPU support
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +struct map_desc;
> +struct sys_timer;
> +
> +/* core initialisation functions */
> +
> +extern void nuc900_init_irq(void);
> +extern struct sys_timer nuc900_timer;
> diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
> index a2c4e2d..fa27c49 100644
> --- a/arch/arm/mach-w90x900/time.c
> +++ b/arch/arm/mach-w90x900/time.c
> @@ -33,6 +33,8 @@
> ?#include <mach/map.h>
> ?#include <mach/regs-timer.h>
>
> +#include "nuc9xx.h"
> +
> ?#define RESETINT ? ? ? 0x1f
> ?#define PERIOD ? ? ? ? (0x01 << 27)
> ?#define ONESHOT ? ? ? ? ? ? ? ?(0x00 << 27)
> --
> 1.7.4.4
>
>



-- 
Wan ZongShun.
www.mcuos.com
