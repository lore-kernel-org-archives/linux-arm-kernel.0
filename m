From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 28 May 2014 12:34:42 -0700
Subject: [PATCH 0/5] serial: imx: fixes
In-Reply-To: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
Message-ID: <20140528193442.GA7066@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 04:19:43PM +0100, dean_jenkins at mentor.com wrote:
> From: Dean Jenkins <Dean_Jenkins@mentor.com>
> 
> The following set of patches were tested on an i.MX6 multi-core platform.
> 
> Patches 1 to 4 were tested using a Bluetooth BCSP UART connection at 115.2kbps
> and 4Mbps. The fixes were needed because the i.MX6 UART driver caused spinlock
> deadlocks with the HCI TTY layer.
> 
> Patch 5 improves the i.MX6 UART driver for use with kdb.
> 
> Patch 1: serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
> Patch 2: serial: imx: remove uart_write_wakeup() from imx_transmit_buffer()
> Patch 3: serial: imx: avoid spinlock recursion deadlock
> Patch 4: serial: imx: move imx_transmit_buffer() into imx_txint()
> Patch 5: serial: imx: clean up imx_poll_get_char()
> 
> The patches are based off 3.15-rc4.
> 
> ----------------------------------------------------------------
> Andy Lowe (1):
>       serial: imx: avoid spinlock recursion deadlock
> 
> Dirk Behme (4):
>       serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
>       serial: imx: remove uart_write_wakeup() from imx_transmit_buffer()
>       serial: imx: move imx_transmit_buffer() into imx_txint()
>       serial: imx: clean up imx_poll_get_char()
> 
>  drivers/tty/serial/imx.c |   73 ++++++++++++++--------------------------------
>  1 file changed, 22 insertions(+), 51 deletions(-)

Given the rather confusing threads based on these patches, I don't know
what to apply.

Dean, can you respin what patches you want applied and resend them so
I'm not so confused?

thanks,

greg k-h
