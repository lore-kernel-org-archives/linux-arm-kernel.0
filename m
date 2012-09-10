From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 10 Sep 2012 16:00:05 -0700
Subject: [PATCH] serial: mxs-auart: put the device when exit or error
In-Reply-To: <1346985187-30459-1-git-send-email-b32955@freescale.com>
References: <20120907024349.GH26709@S2101-09.ap.freescale.net>
 <1346985187-30459-1-git-send-email-b32955@freescale.com>
Message-ID: <20120910230005.GA15782@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 10:33:07AM +0800, Huang Shijie wrote:
> We call the get_device() in the mxs_auart_probe().
> For the balance of the reference count, we should put the
> device in the mxs_auart_remove() or in the error path of
> probe.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/tty/serial/mxs-auart.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

I already applied the previous version, so can you make up a patch
against the tty-next tree that fixes it up properly based on this patch?

thanks,

greg k-h
