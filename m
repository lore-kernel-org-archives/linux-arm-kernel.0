From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Apr 2013 09:53:21 +0100
Subject: [PATCH v2] serial: pl011: Add Device Tree support to request
 DMA channels
In-Reply-To: <201304201233.45501.arnd@arndb.de>
References: <1366272857-14038-1-git-send-email-lee.jones@linaro.org>
 <201304201233.45501.arnd@arndb.de>
Message-ID: <20130421085321.GD14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 20, 2013 at 12:33:45PM +0200, Arnd Bergmann wrote:
> @@ -315,6 +325,7 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
>  struct dma_uap {
>  	struct list_head node;
>  	struct uart_amba_port *uap;
> +	struct device *dev;

There is really no need for this.  This device is available via uap->port.dev.
