From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 14 May 2018 11:01:36 -0700
Subject: [patch v20 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <1526314803-3532-2-git-send-email-oleksandrs@mellanox.com>
References: <1526314803-3532-1-git-send-email-oleksandrs@mellanox.com>
 <1526314803-3532-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <338d958b-f3c3-15b8-32b9-9d30bfb348b5@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2018 09:20 AM, Oleksandr Shamray wrote:

Hi,
Just a bit more Kconfig fixing below.

> ---
>  Documentation/ioctl/ioctl-number.txt |    2 +
>  MAINTAINERS                          |   10 ++
>  drivers/Kconfig                      |    2 +
>  drivers/Makefile                     |    1 +
>  drivers/jtag/Kconfig                 |   18 +++
>  drivers/jtag/Makefile                |    1 +
>  drivers/jtag/jtag.c                  |  274 ++++++++++++++++++++++++++++++++++
>  include/linux/jtag.h                 |   41 +++++
>  include/uapi/linux/jtag.h            |  105 +++++++++++++
>  9 files changed, 454 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/jtag/Kconfig
>  create mode 100644 drivers/jtag/Makefile
>  create mode 100644 drivers/jtag/jtag.c
>  create mode 100644 include/linux/jtag.h
>  create mode 100644 include/uapi/linux/jtag.h

> diff --git a/drivers/jtag/Kconfig b/drivers/jtag/Kconfig
> new file mode 100644
> index 0000000..ba72a2b
> --- /dev/null
> +++ b/drivers/jtag/Kconfig
> @@ -0,0 +1,18 @@
> +menuconfig JTAG
> +	tristate "JTAG support"
> +	help
> +	  This provides basic core functionality support for JTAG class devices

(end sentence above with '.')                                           devices.

> +	  Hardware that is equipped with a JTAG microcontroller can be
> +	  supported by using this driver's interfaces.
> +	  This driver exposes a set of IOCTL to the user space for

	                               IOCTLs

> +	  another commands:

	  various commands:
or
	  the following commands:
or
	  associated commands:

> +	  SDR: (Scan Data Register) Performs an IEEE 1149.1 Data Register scan
> +	  SIR: (Scan Instruction Register) Performs an IEEE 1149.1 Instruction
> +	  Register scan.
> +	  RUNTEST: Forces the IEEE 1149.1 bus to a run state for a specified
> +	  number of clocks or a specified time period.
> +
> +	  If you want this support, you should say Y here.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called jtag.
thanks,
-- 
~Randy
