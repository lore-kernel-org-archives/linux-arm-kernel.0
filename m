From: rdunlap@infradead.org (Randy Dunlap)
Date: Wed, 2 Aug 2017 08:31:29 -0700
Subject: [patch v1 2/2] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <ce3c9f04-1651-8b59-839e-e27783b222ff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2017 06:18 AM, Oleksandr Shamray wrote:
> 
> diff --git a/drivers/jtag/Kconfig b/drivers/jtag/Kconfig
> index a8d0149..7bf709c 100644
> --- a/drivers/jtag/Kconfig
> +++ b/drivers/jtag/Kconfig
> @@ -16,3 +16,16 @@ menuconfig JTAG
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called jtag.
>  
> +menuconfig JTAG_ASPEED
> +	tristate "Aspeed SoC JTAG controller support"
> +	depends on JTAG
> +	---help---
> +	  This provides a support for Aspeed JTAG device, equipped on
> +	  Aspeed SoC 24xx and 25xx families. Drivers allows programming
> +	  of hardware devices, connected to SoC through the JTAG interface.
> +
> +	  If you want this support, you should say Y here.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called aspeed_jtag.

In the Makefile, it looks like it is called jtag-aspeed.

> +
> diff --git a/drivers/jtag/Makefile b/drivers/jtag/Makefile
> index e811330..e9fa7fa 100644
> --- a/drivers/jtag/Makefile
> +++ b/drivers/jtag/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_JTAG)		+= jtag.o
> +obj-$(CONFIG_JTAG_ASPEED)	+= jtag-aspeed.o


-- 
~Randy
