From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Oct 2010 10:00:09 -0700
Subject: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
In-Reply-To: <1287387875-14168-2-git-send-email-ohad@wizery.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-2-git-send-email-ohad@wizery.com>
Message-ID: <20101022170008.GG9149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [101018 00:41]:
> From: Simon Que <sque@ti.com>
> 
> Add driver for OMAP's Hardware Spinlock module.
> 
> The OMAP Hardware Spinlock module, initially introduced in OMAP4,
> provides hardware assistance for synchronization between the
> multiple processors in the device (Cortex-A9, Cortex-M3 and
> C64x+ DSP).

...

> +EXPORT_SYMBOL_GPL(omap_hwspin_trylock);
> +EXPORT_SYMBOL_GPL(omap_hwspin_lock_timeout);
> +EXPORT_SYMBOL_GPL(omap_hwspin_unlock);
> +EXPORT_SYMBOL_GPL(omap_hwspinlock_request);
> +EXPORT_SYMBOL_GPL(omap_hwspinlock_request_specific);
> +EXPORT_SYMBOL_GPL(omap_hwspinlock_free);
> +EXPORT_SYMBOL_GPL(omap_hwspinlock_get_id);

Please let's not add yet another omap specific layer that will
make it incrementally harder to have generic drivers.

Instead, we can do the omap specific locking in the
platform code and then the drivers can use the functions
passed in the platform_data if they're implemented.

Regards,

Tony
