From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 16 Sep 2016 17:47:01 +0200
Subject: [PATCH] musb: Export musb_root_disconnect for use in modules
In-Reply-To: <20160916145936.3297-1-hdegoede@redhat.com>
References: <20160916145936.3297-1-hdegoede@redhat.com>
Message-ID: <20160916154701.GA20742@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 04:59:36PM +0200, Hans de Goede wrote:
> Export musb_root_disconnect for use in modules, so that musb glue
> code build as module can use it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/usb/musb/musb_virthub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
> index fe08e77..61b5f1c 100644
> --- a/drivers/usb/musb/musb_virthub.c
> +++ b/drivers/usb/musb/musb_virthub.c
> @@ -245,6 +245,7 @@ void musb_root_disconnect(struct musb *musb)
>  			usb_otg_state_string(musb->xceiv->otg->state));
>  	}
>  }
> +EXPORT_SYMBOL_GPL(musb_root_disconnect);
>  
>  
>  /*---------------------------------------------------------------------*/

Does this fix a build error somehow?  Who reported it?
