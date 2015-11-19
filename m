From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 19 Nov 2015 14:10:53 +0000
Subject: [PATCH 05/12] tty: amba-pl011: add register lookup table
In-Reply-To: <E1ZyNlS-0003jg-46@rmk-PC.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNlS-0003jg-46@rmk-PC.arm.linux.org.uk>
Message-ID: <20151119141027.GA1764@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 05:40:26PM +0000, Russell King wrote:
> Add a register lookup table, which allows the register offsets to be
> adjusted on a per-port basis.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

[...]

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 5ea5b0a3dbb9..628557f6a7a1 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -73,6 +73,34 @@
>  #define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
>  #define UART_DUMMY_DR_RX	(1 << 16)
>  
> +static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {

Any reason not to make all these tables const?

Unless I missed something, I don't see them modified anywhere.

[...]

Cheers
---Dave
