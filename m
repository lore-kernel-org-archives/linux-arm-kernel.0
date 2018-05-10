From: rdunlap@infradead.org (Randy Dunlap)
Date: Thu, 10 May 2018 09:09:45 -0700
Subject: [patch v19 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <1525967064-10760-2-git-send-email-oleksandrs@mellanox.com>
References: <1525967064-10760-1-git-send-email-oleksandrs@mellanox.com>
 <1525967064-10760-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <a6ff3a11-3fe5-311e-3097-d6477ed86015@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2018 08:44 AM, Oleksandr Shamray wrote:
> Initial patch for JTAG driver
> JTAG class driver provide infrastructure to support hardware/software
> JTAG platform drivers. It provide user layer API interface for flashing
> and debugging external devices which equipped with JTAG interface
> using standard transactions.

> ---
>  Documentation/ioctl/ioctl-number.txt |    2 +
>  MAINTAINERS                          |   10 ++
>  drivers/Kconfig                      |    2 +
>  drivers/Makefile                     |    1 +
>  drivers/jtag/Kconfig                 |   16 ++
>  drivers/jtag/Makefile                |    1 +
>  drivers/jtag/jtag.c                  |  273 ++++++++++++++++++++++++++++++++++
>  include/linux/jtag.h                 |   41 +++++
>  include/uapi/linux/jtag.h            |  105 +++++++++++++
>  9 files changed, 451 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/jtag/Kconfig
>  create mode 100644 drivers/jtag/Makefile
>  create mode 100644 drivers/jtag/jtag.c
>  create mode 100644 include/linux/jtag.h
>  create mode 100644 include/uapi/linux/jtag.h
> 
> diff --git a/drivers/jtag/Kconfig b/drivers/jtag/Kconfig
> new file mode 100644
> index 0000000..5e2c75b
> --- /dev/null
> +++ b/drivers/jtag/Kconfig
> @@ -0,0 +1,16 @@
> +menuconfig JTAG
> +	tristate "JTAG support"
> +	help
> +	  This provides basic core functionality support for jtag class devices

	                                                     JTAG class devices.

> +	  Hardware equipped with JTAG microcontroller which can be built

I'm having problems understanding the line above + first 1/2 of the line below.
Maybe something like:

	  Hardware that is equipped with a JTAG microcontroller can be
	  supported by using this driver's interfaces.

> +	  on top of this drivers. Driver exposes the set of IOCTL to the

	                          This driver exposes a set of IOCTLs to

> +	  user space for:

> +	  SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);

	                                              ^^^^? Instruction?

> +	  SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);

	                                       ^^^^^^^^^^^? Data?

> +	  RUNTEST (Forces IEEE 1149.1 bus to a run state for specified
> +	  number of clocks).
> +
> +	  If you want this support, you should say Y here.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called jtag.


-- 
~Randy
