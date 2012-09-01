From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 1 Sep 2012 20:25:27 +0000
Subject: [PATCH 2/2] ARM: allow for ATAGS to be configured out when DT
 support is selected
In-Reply-To: <1346361008-7320-2-git-send-email-nicolas.pitre@linaro.org>
References: <1346361008-7320-1-git-send-email-nicolas.pitre@linaro.org>
 <1346361008-7320-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <201209012025.27962.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 August 2012, Nicolas Pitre wrote:
> Now that ATAGS support is well contained, we can easily remove it from
> the kernel build if so desired.  It has to explicitly be disabled, and
> only when DT support is selected.
> 
> Note: disabling kernel ATAGS support does not prevent the usage of
> CONFIG_ARM_ATAG_DTB_COMPAT.

> ...

> +config ATAGS
> +	bool "Support for the traditional ATAGS boot data passing" if USE_OF
> +	default y
> +	help
> +	  This is the traditional way of passing data to the kernel at boot
> +	  time. If you are solely relying on the flattened device tree (or
> +	  the ARM_ATAG_DTB_COMPAT option) then you may unselect this option
> +	  to remove ATAGS support from your kernel binary.  If unsure,
> +	  leave this to y.

That's a clever way of implementing it, I had not though of making it an
optional default-y symbol.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Should we do patches to the individual platforms bsaed on this to disable
the ATAG based board files when CONFIG_ATAG is disabled?

	Arnd
