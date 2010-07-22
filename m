From: randy.dunlap@oracle.com (Randy Dunlap)
Date: Thu, 22 Jul 2010 10:17:53 -0700
Subject: [PATCH v4] gpio: sx150x: Add Semtech I2C sx150x gpio expander
	driver.
In-Reply-To: <1279818771-9428-1-git-send-email-gbean@codeaurora.org>
References: <1279818771-9428-1-git-send-email-gbean@codeaurora.org>
Message-ID: <20100722101753.c73604eb.randy.dunlap@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jul 2010 10:12:51 -0700 Gregory Bean wrote:

>  drivers/gpio/Kconfig       |   11 +
>  drivers/gpio/Makefile      |    1 +
>  drivers/gpio/sx150x.c      |  645 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/sx150x.h |   78 ++++++
>  4 files changed, 735 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/gpio/sx150x.c
>  create mode 100644 include/linux/i2c/sx150x.h
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 7face91..f623953 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -195,6 +195,17 @@ config GPIO_PCF857X
>  	  This driver provides an in-kernel interface to those GPIOs using
>  	  platform-neutral GPIO calls.
>  
> +config GPIO_SX150X
> +	bool "Semtech SX150x I2C GPIO expander"
> +	depends on I2C=y
> +	default n
> +	help
> +	  Say yes here to provide support for Semtech SX150-series I2C
> +	  GPIO expanders. Compatible models include:

Just curious, not complaining, but why does this driver (and some others)
need to be built-in instead of having the option of being built as a
loadable module?


> +	  8 bits:  sx1508q
> +	  16 bits: sx1509q
> +
>  config GPIO_TC35892
>  	bool "TC35892 GPIOs"
>  	depends on MFD_TC35892




---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
