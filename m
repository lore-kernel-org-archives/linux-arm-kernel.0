From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Tue, 31 Jul 2018 17:09:10 +0200
Subject: [RESEND PATCH 1/6] rapidio: define top Kconfig menu in driver
 subtree
In-Reply-To: <20180731142954.30345-2-acolin@isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-2-acolin@isi.edu>
Message-ID: <053432eb-1f24-a763-0bfe-e67373e7ea82@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 31/07/18 16:29, Alexei Colin wrote:
> The top-level Kconfig entry for RapidIO subsystem is currently
> duplicated in several architecture-specific Kconfigs. This
> commit re-defines it in the driver subtree, and subsequent
> commits, one per architecture, will remove the duplicated
> definitions from respective per-architecture Kconfigs.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Paul Walters <jwalters@isi.edu>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Anvin <hpa@zytor.com>
> Cc: x86 at kernel.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-mips at linux-mips.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Alexei Colin <acolin@isi.edu>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>  drivers/rapidio/Kconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
> index d6d2f20c4597..98e301847584 100644
> --- a/drivers/rapidio/Kconfig
> +++ b/drivers/rapidio/Kconfig
> @@ -1,6 +1,21 @@
>  #
>  # RapidIO configuration
>  #
> +
> +config HAS_RAPIDIO
> +	bool
> +	default n
> +
> +config RAPIDIO
> +	tristate "RapidIO support"
> +	depends on HAS_RAPIDIO || PCI
> +	help
> +	  This feature enables support for RapidIO high-performance
> +	  packet-switched interconnect.
> +
> +	  If you say Y here, the kernel will include drivers and
> +	  infrastructure code to support RapidIO interconnect devices.
> +
>  source "drivers/rapidio/devices/Kconfig"
>  
>  config RAPIDIO_DISC_TIMEOUT

-- 
Best regards,
Alexander Sverdlin.
