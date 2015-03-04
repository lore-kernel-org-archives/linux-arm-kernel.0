From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Mar 2015 15:44:03 +0000
Subject: [PATCH v3 2/9] mfd: syscon: Add atmel system timer registers
 definition
In-Reply-To: <1425478897-27322-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425478897-27322-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150304154403.GM32624@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Mar 2015, Alexandre Belloni wrote:

> AT91RM920 has a memory range reserved for timer and watchdog configuration.
> Expose those registers so that drivers can make use of the system timer syscon
> declared in at91 DTs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  include/linux/mfd/syscon/atmel-st.h | 47 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 include/linux/mfd/syscon/atmel-st.h
> 
> diff --git a/include/linux/mfd/syscon/atmel-st.h b/include/linux/mfd/syscon/atmel-st.h
> new file mode 100644
> index 000000000000..8e29a1028807
> --- /dev/null
> +++ b/include/linux/mfd/syscon/atmel-st.h
> @@ -0,0 +1,47 @@
> +/*
> + * Copyright (C) 2005 Ivan Kokshaysky
> + * Copyright (C) SAN People
> + *
> + * System Timer (ST) - System peripherals registers.
> + * Based on AT91RM9200 datasheet revision E.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef _LINUX_MFD_SYSCON_ATMEL_ST_H
> +#define _LINUX_MFD_SYSCON_ATMEL_ST_H
> +
> +#define	AT91_ST_CR	0x00	/* Control Register */
> +#define		AT91_ST_WDRST	(1 << 0)	/* Watchdog Timer Restart */

Please use BIT() for "1 <<".

> +#define	AT91_ST_PIMR	0x04	/* Period Interval Mode Register */
> +#define		AT91_ST_PIV	(0xffff <<  0)	/* Period Interval Value */
> +
> +#define	AT91_ST_WDMR	0x08	/* Watchdog Mode Register */
> +#define		AT91_ST_WDV	(0xffff <<  0)	/* Watchdog Counter Value */
> +#define		AT91_ST_RSTEN	(1 << 16)	/* Reset Enable */
> +#define		AT91_ST_EXTEN	(1 << 17)	/* External Signal Assertion Enable */
> +
> +#define	AT91_ST_RTMR	0x0c	/* Real-time Mode Register */
> +#define		AT91_ST_RTPRES	(0xffff <<  0)	/* Real-time Prescalar Value */
> +
> +#define	AT91_ST_SR	0x10	/* Status Register */
> +#define		AT91_ST_PITS	(1 << 0)	/* Period Interval Timer Status */
> +#define		AT91_ST_WDOVF	(1 << 1)	/* Watchdog Overflow */
> +#define		AT91_ST_RTTINC	(1 << 2)	/* Real-time Timer Increment */
> +#define		AT91_ST_ALMS	(1 << 3)	/* Alarm Status */
> +
> +#define	AT91_ST_IER	0x14	/* Interrupt Enable Register */
> +#define	AT91_ST_IDR	0x18	/* Interrupt Disable Register */
> +#define	AT91_ST_IMR	0x1c	/* Interrupt Mask Register */
> +
> +#define	AT91_ST_RTAR	0x20	/* Real-time Alarm Register */
> +#define		AT91_ST_ALMV	(0xfffff << 0)	/* Alarm Value */
> +
> +#define	AT91_ST_CRTR	0x24	/* Current Real-time Register */
> +#define		AT91_ST_CRTV	(0xfffff << 0)	/* Current Real-Time Value */
> +
> +#endif /* _LINUX_MFD_SYSCON_ATMEL_ST_H */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
