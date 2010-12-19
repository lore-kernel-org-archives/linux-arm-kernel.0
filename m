From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Dec 2010 16:21:15 +0000
Subject: [PATCH] RFC: PL08X DMA driver and signal muxing
In-Reply-To: <1274139588-12934-1-git-send-email-linus.walleij@stericsson.com>
References: <1274139588-12934-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101219162115.GA27774@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 01:39:47AM +0200, Linus Walleij wrote:
> +#define DRIVER_NAME	"pl08xdmac"
...
> +static struct amba_driver pl08x_amba_driver = {
> +	.drv.name	= DRIVER_NAME,
> +	.id_table	= pl08x_ids,
> +	.probe		= pl08x_probe,
> +};

Having just enabled this on Versatile Express, this is what I see in
/sys/bus/amba/drivers/:

drwxr-xr-x    2 root     root            0 Jan  1  1970 aaci-pl041
drwxr-xr-x    2 root     root            0 Jan  1  1970 clcd-pl11x
drwxr-xr-x    2 root     root            0 Jan  1  1970 kmi-pl050
drwxr-xr-x    2 root     root            0 Jan  1  1970 mmci-pl18x
drwxr-xr-x    2 root     root            0 Jan  1  1970 pl08xdmac
drwxr-xr-x    2 root     root            0 Jan  1  1970 rtc-pl031
drwxr-xr-x    2 root     root            0 Jan  1  1970 uart-pl011

Is there a reason why the dmac uses a different naming convention from
all other primecell drivers?  Can it be renamed to "dmac-pl08x" please ?
