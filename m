From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 26 Mar 2015 23:01:13 +0100
Subject: [PATCH] serial: imx: protect Soft Reset of port with lock
In-Reply-To: <1426228691-20529-1-git-send-email-jiada_wang@mentor.com>
References: <1426228691-20529-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <20150326220113.GA24630@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 03:38:11PM +0900, Jiada Wang wrote:
> Previously Soft Reset (clear of SRST bit in UCR2 register)
> of UART in startup is not protected by lock, which may have race
> with console_write, as console_write may occur at anytime even
> when UART port is shutdown.
> 
> To avoid this race, protect Soft reset of UART port with spin_lock.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  drivers/tty/serial/imx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Doesn't apply to my tree :(
