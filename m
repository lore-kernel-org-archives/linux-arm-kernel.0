From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 26 Mar 2015 22:26:41 +0100
Subject: [PATCH v2 2/2] serial/amba-pl011: Leave the TX IRQ alone when
 the UART is not open
In-Reply-To: <1426262182-2298-3-git-send-email-Dave.Martin@arm.com>
References: <1426262182-2298-1-git-send-email-Dave.Martin@arm.com>
 <1426262182-2298-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150326212641.GA21554@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 03:56:22PM +0000, Dave Martin wrote:
> Getting the TX IRQ re-asserted from scratch can be inefficient in
> some setups.
> 
> This patch avoids clearing the TX IRQ across pl011_shutdown()...
> pl011_startup(), so that if the port is closed and reopened, the
> IRQ will still work afterwards without having to bootstrap it again.
> 
> The TX IRQ continues to be masked in IMSC when the UART is not in
> use.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  drivers/tty/serial/amba-pl011.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

This doesn't apply to my tty-testing branch of tty.git on git.kernel.org
:(

Can you please rebase it and resend?

thanks,

greg k-h
