From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jul 2014 08:44:47 -0500
Subject: [PATCH 1/9] usb: musb: core: cleanup - remove some useless
 'break's from switch statements
In-Reply-To: <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140718134447.GA24914@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Fri, Jul 18, 2014 at 11:31:22AM +0200, Lothar Wa?mann wrote:
> 

no commit log == no commit, also the worst thing you can do is have your
bug fixes depend on cleanups. This is *not* a bug fix by any stretch of
the imagination.

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/usb/musb/musb_core.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index b841ee0..8623112 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -680,7 +680,6 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>  		default:
>  			/* "should not happen" */
>  			musb->is_active = 0;
> -			break;
>  		}
>  	}
>  
> @@ -737,7 +736,6 @@ b_host:
>  				if (hcd)
>  					hcd->self.is_b_host = 0;
>  			}
> -			break;
>  		}
>  
>  		musb_host_poke_root_hub(musb);
> @@ -787,7 +785,6 @@ b_host:
>  		default:
>  			WARNING("unhandled DISCONNECT transition (%s)\n",
>  				usb_otg_state_string(musb->xceiv->state));
> -			break;
>  		}
>  	}
>  
> @@ -2015,7 +2012,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
>  		break;
>  	default:
>  		dev_err(dev, "unsupported port mode %d\n", musb->port_mode);
> -		break;
>  	}
>  
>  	if (status < 0)
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/3981912b/attachment-0001.sig>
