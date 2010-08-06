From: gregkh@suse.de (Greg KH)
Date: Fri, 6 Aug 2010 08:39:03 -0700
Subject: [PATCH 5/5] U6715 16550A serial driver support
In-Reply-To: <1281011335-25761-6-git-send-email-philippe.langlais@stericsson.com>
References: <1281011335-25761-1-git-send-email-philippe.langlais@stericsson.com>
	<1281011335-25761-6-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20100806153903.GA6255@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 05, 2010 at 02:28:55PM +0200, Philippe Langlais wrote:
> UART Features extract from STEricsson U6715 data-sheet (arm926 SoC for mobile phone):
> * Fully compatible with industry standard 16C550 and 16C450 from various
> manufacturers
> * RX and TX 64 byte FIFO reduces CPU interrupts
> * Full double buffering
> * Modem control signals include CTS, RTS, (and DSR, DTR on UART1 only)
> * Automatic baud rate selection
> * Manual or automatic RTS/CTS smart hardware flow control
> * Programmable serial characteristics:
> ? Baud rate generation (50 to 3.25M baud)
> ? 5, 6, 7 or 8-bit characters
> ? Even, odd or no-parity bit generation and detection
> ? 1, 1.5 or 2 stop bit generation
> * Independent control of transmit, receive, line status, data set interrupts and FIFOs
> * Full status-reporting capabilities
> * Separate DMA signaling for RX and TX
> * Timed interrupt to spread receive interrupt on known duration
> * DMA time-out interrupt to allow detection of end of reception
> * Carkit pulse coding and decoding compliant with USB carkit control interface [40]
> 
> In 16550A auto-configuration, if the fifo size is 64 then it's an U6 16550A port.
> Add set_termios hook & export serial8250_do_set_termios,
> this feature is used in our U6715 8250 platform serial driver, to avoid
> hack in 8250.c set_termios.
> In this driver the input uart clock frequency depends on baud rate and
> is computed in our set_termios override function.
> 
> Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

But isn't this patch needed before the last one in this series in order
to keep everything building properly?

You might want to move it up to the first one.

thanks,

greg k-h
