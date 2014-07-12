From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 11 Jul 2014 17:51:22 -0700
Subject: [PATCH 2/2] tty: serial: fsl_lpuart: add 32-bit register
 interface support
In-Reply-To: <1405057302-26041-3-git-send-email-jingchang.lu@freescale.com>
References: <1405057302-26041-1-git-send-email-jingchang.lu@freescale.com>
 <1405057302-26041-3-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20140712005122.GA31974@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 01:41:42PM +0800, Jingchang Lu wrote:
> This add the 32-bit register version LPUART support with big-endian
> byte order.
> 
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 653 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 643 insertions(+), 10 deletions(-)

You didn't even test build this patch:

  CC [M]  drivers/tty/serial/fsl_lpuart.o
drivers/tty/serial/fsl_lpuart.c: In function ?lpuart_suspend?:
drivers/tty/serial/fsl_lpuart.c:1856:22: error: ?lpuart32_reg? undeclared (first use in this function)
   uart_suspend_port(&lpuart32_reg, &sport->port);
                      ^

No quicker way to make me grumpy...

Please take some time to do this right.

greg k-h
