From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Oct 2014 12:36:30 +0200
Subject: [PATCH v2] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <1411983159-4692-1-git-send-email-anders.berg@avagotech.com>
References: <1411983159-4692-1-git-send-email-anders.berg@avagotech.com>
Message-ID: <20141003103630.GB1349@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2ac87fa..8983474 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -77,6 +77,17 @@ config I2C_AMD8111
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-amd8111.
>  
> +config I2C_AXXIA
> +	tristate "Axxia I2C controller"
> +	depends on ARCH_AXXIA || COMPILE_TEST
> +	default ARCH_AXXIA
> +	help
> +	  Say yes if you want to support the I2C bus on Axxia platforms.
> +
> +	  Please note that this controller is limited to transfers of maximum
> +	  255 bytes in length. Any attempt to to a larger transfer will return
> +	  an error.
> +
>  config I2C_I801
>  	tristate "Intel 82801 (ICH/PCH)"
>  	depends on PCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 49bf07e..5899edb 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
>  obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
>  obj-$(CONFIG_I2C_AMD756_S4882)	+= i2c-amd756-s4882.o
>  obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
> +obj-$(CONFIG_I2C_AXXIA)		+= i2c-axxia.o
>  obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
>  obj-$(CONFIG_I2C_ISCH)		+= i2c-isch.o
>  obj-$(CONFIG_I2C_ISMT)		+= i2c-ismt.o

Please put it to the embedded section.

...

> +	idev->adapter.class = I2C_CLASS_HWMON;

Being a DT driver, you most probably don't need this.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141003/5874892a/attachment.sig>
