From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 28 Dec 2016 09:15:25 +0100
Subject: [RFC PATCH net-next v4 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <1481720175-12703-1-git-send-email-andrei.pistirica@microchip.com>
References: <1481720175-12703-1-git-send-email-andrei.pistirica@microchip.com>
Message-ID: <20161228081524.GA3826@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 02:56:14PM +0200, Andrei Pistirica wrote:
> Note 1: Kbuild uses "select" instead of "imply", and the macb maintainer agreed
>         to make the change when it will be available in net-next.

> +config MACB_USE_HWSTAMP
> +	bool "Use IEEE 1588 hwstamp"
> +	depends on MACB
> +	default y
> +	select PTP_1588_CLOCK

The imply key word has been merged as of:

    237e3ad Kconfig: Introduce the "imply" keyword

Please use it.

Thanks,
Richard


> +	---help---
> +	  Enable IEEE 1588 Precision Time Protocol (PTP) support for MACB.
