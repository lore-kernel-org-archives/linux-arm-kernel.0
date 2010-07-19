From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 19 Jul 2010 10:18:37 +1000
Subject: [PATCH] Orion: DNS-323 C1 requires phylib
In-Reply-To: <20100716153151.GA9307@jirafa.cyrius.com>
References: <20100716153151.GA9307@jirafa.cyrius.com>
Message-ID: <1279498717.10390.1778.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-16 at 16:31 +0100, Martin Michlmayr wrote:
> The code to support the DNS-323 rev C1 added a call to
> phy_register_fixup_for_uid() and therefore phylib has to
> be built in.
> 
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

Oops ;-) Ack.

Cheers,
Ben.

> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> index 905719a..c897e03 100644
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ b/arch/arm/mach-orion5x/Kconfig
> @@ -26,6 +26,7 @@ config MACH_KUROBOX_PRO
>  config MACH_DNS323
>  	bool "D-Link DNS-323"
>  	select I2C_BOARDINFO
> +	select PHYLIB
>  	help
>  	  Say 'Y' here if you want your kernel to support the
>  	  D-Link DNS-323 platform.
> 
