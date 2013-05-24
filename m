From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Fri, 24 May 2013 09:46:32 -0300
Subject: [PATCHv3 1/6] net: Add EMAC ethernet driver found on Allwinner
 A10 SoC's
In-Reply-To: <1369387394-9453-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1369387394-9453-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369387394-9453-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <519F6128.9060608@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 24/05/13 06:23, Maxime Ripard escribi?:
> From: Stefan Roese <sr@denx.de>
> 
> The Allwinner A10 has an ethernet controller that seem to be developped
> internally by them.
> 
> The exact feature set of this controller is unknown, since there is no
> public documentation for this IP, and this driver is mostly the one
> published by Allwinner that has been heavily cleaned up.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

(snip)

> +
> +config SUN4I_EMAC
> +        tristate "Allwinner A10 EMAC support"
> +	depends on ARCH_SUNXI
> +	depends on OF
> +	select CRC32
> +	select NET_CORE
> +	select MII
> +	select REGULATOR_FIXED_VOLTAGE
> +        ---help---
> +          Support for Allwinner A10 EMAC ethernet driver.
> +
> +          To compile this driver as a module, choose M here.  The module
> +          will be called sun4i-emac.
> +

You also need to select REGULATOR when you select REGULATOR_FIXED_VOLTAGE

I have attached a fixup patch you can use with git autosquash

Cheers,

Emilio
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fixup-regulator.patch
Type: text/x-diff
Size: 735 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130524/1ad42136/attachment.bin>
