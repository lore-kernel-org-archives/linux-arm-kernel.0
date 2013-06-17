From: horms@verge.net.au (Simon Horman)
Date: Mon, 17 Jun 2013 19:13:18 +0900
Subject: [PATCH 1/3] serial: sh-sci: HSCIF support
In-Reply-To: <1371461329-26467-2-git-send-email-horms+renesas@verge.net.au>
References: <1371461329-26467-1-git-send-email-horms+renesas@verge.net.au>
 <1371461329-26467-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130617101318.GA28277@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Cc Greg Kroah-Hartman <gregkh@linuxfoundation.org> ]

On Mon, Jun 17, 2013 at 06:28:47PM +0900, Simon Horman wrote:
> From: Ulrich Hecht <ulrich.hecht@gmail.com>
> 
> Adds support for "High Speed Serial Communications Interface with FIFO",
> essentially a SCIF with 128-byte FIFOs and more accurate baud rate
> generator.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

[ snip ]

> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 74c2bf7..26eee07 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -226,4 +226,7 @@
>  /* Rocketport EXPRESS/INFINITY */
>  #define PORT_RP2	102
>  
> +/* SH-SCI */
> +#define PORT_HSCIF	103
> +
>  #endif /* _UAPILINUX_SERIAL_CORE_H */

It seems that 103 conflicts with #define PORT_LPUART   103
which is present in commit c9e2e946fb0b ("tty:
serial: add Freescale lpuart driver support") which is
in turn present in linux-next via tty-next.

Should I re-spin this patch using 104 for PORT_HSCIF ?
