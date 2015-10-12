From: marex@denx.de (Marek Vasut)
Date: Mon, 12 Oct 2015 16:00:55 +0200
Subject: [PATCH] crypto: mxs-dcp is an stmp device
In-Reply-To: <6543300.PJNp8A08gY@wuerfel>
References: <6543300.PJNp8A08gY@wuerfel>
Message-ID: <201510121600.55665.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 12, 2015 at 03:52:34 PM, Arnd Bergmann wrote:
> The mxs-dcp driver relies on the stmp_reset_block() helper function, which
> is provided by CONFIG_STMP_DEVICE. This symbol is always set on MXS,
> but the driver can now also be built for MXC (i.MX6)

That is correct.

> , which results in a built error if no other driver selects STMP_DEVICE:

Ouch.

> drivers/built-in.o: In function `mxs_dcp_probe':
> vf610-ocotp.c:(.text+0x3df302): undefined reference to `stmp_reset_block'
> 
> This adds the 'select', like all other stmp drivers have it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a2712e6c75f ("crypto: mxs-dcp - Allow MXS_DCP to be used on MX6SL")

Acked-by: Marek Vasut <marex@denx.de>

> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index ab7e3b668890..2569e043317e 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -430,6 +430,7 @@ endif
>  config CRYPTO_DEV_MXS_DCP
>  	tristate "Support for Freescale MXS DCP"
>  	depends on (ARCH_MXS || ARCH_MXC)
> +	select STMP_DEVICE
>  	select CRYPTO_CBC
>  	select CRYPTO_ECB
>  	select CRYPTO_AES

Best regards,
Marek Vasut
