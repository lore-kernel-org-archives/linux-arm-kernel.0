From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 17 Mar 2011 23:08:04 +0100
Subject: [PATCH 1/9] lpc2k: Core support
In-Reply-To: <1300377264-10843-2-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-2-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <083DF309106F364B939360100EC290F80B15AC2B3A@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ithamar,

> diff --git a/arch/arm/mach-lpc2k/include/mach/system.h b/arch/arm/mach-
> lpc2k/include/mach/system.h
> new file mode 100644
> index 0000000..fbbea43
> --- /dev/null
> +++ b/arch/arm/mach-lpc2k/include/mach/system.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright 2011 Team Embedded VOF
> + *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef MACH_LPC2K_SYSTEM_H
> +#define MACH_LPC2K_SYSTEM_H
> +
> +static void arch_idle(void)
> +{
> +	cpu_do_idle();
> +}

The 24xx devices have a CPU idle down register (PCON) that will suspend
the CPU clock until the next interrupt. *pcon = 1;

> +
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +	cpu_reset(0);
> +}

The entire system can be reset via RESETOUT using the watchdog timer.
