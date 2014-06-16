From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Jun 2014 20:27:20 +0100
Subject: [PATCH v2 06/10] mfd: Add driver for Maxim 77802 Power
 Management IC
In-Reply-To: <1402941758-11216-7-git-send-email-javier.martinez@collabora.co.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-7-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140616192720.GK5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 08:02:34PM +0200, Javier Martinez Canillas wrote:

> +- max77802,pmic-buck-dvs-gpios: The DVS GPIOs. We'll try to set these GPIOs
> +  to match pmic-buck-default-dvs-idx at probe time if they are defined. If
> +  some or all of these GPIOs are not defined it's assumed that the board has
> +  any missing GPIOs hardwired to match pmic-buck-default-dvs-idx.

I can't tell from reading this what the property means exactly - I
expect it is an array of the GPIOs in some order but that order isn't
specified.

> +config MFD_MAX77802
> +	tristate "Maxim Integrated MAX77802 PMIC Support"
> +	depends on I2C=y
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	select IRQ_DOMAIN
> +	help
> +	  Say yes here to support for Maxim Integrated MAX77802.
> +	  This is a Power Management IC with RTC on chip.
> +	  This driver provides common support for accessing the device;
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +

It is a bit unorthodox to put the build infrastructure in the same patch
as the DT binding...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140616/718375a8/attachment.sig>
