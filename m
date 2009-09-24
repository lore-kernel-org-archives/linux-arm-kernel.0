From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Sep 2009 22:59:15 +0100
Subject: [PATCH] mach-iop32x/ Add nec ns-50 / ApplianceWare sanmina support
In-Reply-To: <87hbut7890.fsf@lechat.rtp-net.org>
References: <87ocr6uyhx.fsf@lechat.rtp-net.org>
	<e9c3a7c20908301646w3cc8199dg392b95faad5616de@mail.gmail.com>
	<87hbut7890.fsf@lechat.rtp-net.org>
Message-ID: <20090924215915.GA27322@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2009 at 09:48:11PM +0200, Arnaud Patard wrote:
> +static struct plat_serial8250_port sanmina_serial_port[] = {
> +	{
> +		.mapbase	= IQ31244_UART,
> +		.membase	= (char *)IQ31244_UART,

This can't be right.

> +		.irq		= IRQ_IOP32X_XINT3,
> +		.flags		= UPF_SKIP_TEST | UPF_SHARE_IRQ,
> +		.iotype		= UPIO_MEM,
> +		.regshift	= 0,
> +		.uartclk	= 14745600,
> +	},
> +	{ },
> +};
> +
> +static struct resource sanmina_uart_resource = {
> +	.start		= IQ31244_UART,
> +	.end		= IQ31244_UART + 0x3f,

and neither can this.  Resources are bus addresses, not virtual addresses.
