From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 16 Feb 2016 00:11:24 +0200
Subject: [PATCH/RFC v2 03/11] soc: renesas: Improve rcar_sysc_power()
 debug info
In-Reply-To: <1455571020-18968-4-git-send-email-geert+renesas@glider.be>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
 <1455571020-18968-4-git-send-email-geert+renesas@glider.be>
Message-ID: <1640540.sfVMLcT3LH@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Monday 15 February 2016 22:16:52 Geert Uytterhoeven wrote:
> Print requested power domain state.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
>   - New.
> ---
>  drivers/soc/renesas/pm-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/renesas/pm-rcar.c b/drivers/soc/renesas/pm-rcar.c
> index bc605d9fbc6ce79c..cc684e9cc8db5d1c 100644
> --- a/drivers/soc/renesas/pm-rcar.c
> +++ b/drivers/soc/renesas/pm-rcar.c
> @@ -128,7 +128,7 @@ static int rcar_sysc_power(const struct rcar_sysc_ch
> *sysc_ch, bool on) out:
>  	spin_unlock_irqrestore(&rcar_sysc_lock, flags);
> 
> -	pr_debug("sysc power domain %d: %08x -> %d\n",
> +	pr_debug("sysc power %s domain %d: %08x -> %d\n", on ? "on" : "off",
>  		 sysc_ch->isr_bit, ioread32(rcar_sysc_base + SYSCISR), ret);
>  	return ret;
>  }

-- 
Regards,

Laurent Pinchart
