From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 19 Oct 2010 10:16:51 -0700
Subject: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
In-Reply-To: <1287387875-14168-2-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Mon, 18 Oct 2010 09:44:33 +0200")
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-2-git-send-email-ohad@wizery.com>
Message-ID: <8739s2xfuk.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ohad Ben-Cohen <ohad@wizery.com> writes:

> From: Simon Que <sque@ti.com>
>
> Add driver for OMAP's Hardware Spinlock module.
>
> The OMAP Hardware Spinlock module, initially introduced in OMAP4,
> provides hardware assistance for synchronization between the
> multiple processors in the device (Cortex-A9, Cortex-M3 and
> C64x+ DSP).

[...]

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index b743312..ce4b7a6 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -390,6 +390,16 @@ config BMP085
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bmp085.
>  
> +config OMAP_HWSPINLOCK
> +	bool "OMAP Hardware Spinlock module"

Should be tristate so it can also be built as a module by default.

e.g., when building multi-OMAP kernels, no reason or this to be
built-in.  It can then be loaded as a module on OMAP4 only.

Kevin
