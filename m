From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 16 Mar 2016 23:50:43 +0100
Subject: [PATCH v2 3/3] phy: mdio-thunder: Add driver for Cavium Thunder
 SoC MDIO buses.
In-Reply-To: <1457718791-6505-4-git-send-email-ddaney.cavm@gmail.com>
References: <1457718791-6505-1-git-send-email-ddaney.cavm@gmail.com>
 <1457718791-6505-4-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <56E9E343.3080207@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 11.03.2016 um 18:53 schrieb David Daney:
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 40faec9..075a4cc 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -196,6 +196,17 @@ config MDIO_OCTEON
>  	  buses. It is required by the Octeon and ThunderX ethernet device
>  	  drivers on some systems.
>  
> +config MDIO_THUNDER
> +	tristate "Support for MDIO buses on on ThunderX SOCs"

Double "on", spotted in next-20160316.

> +	depends on 64BIT
> +	depends on PCI
> +	select MDIO_CAVIUM
> +	help
> +	  This driver supports the MDIO interfaces found on Cavium
> +	  ThunderX SoCs when the MDIO bus device appears on as a PCI
> +	  device.

While at it, this sentence sounds weird. Did you mean s/as/is/? Or is
there another verb missing in there?

Regards,
Andreas

> +
> +
>  config MDIO_SUN4I
>  	tristate "Allwinner sun4i MDIO interface support"
>  	depends on ARCH_SUNXI
[snip]

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
