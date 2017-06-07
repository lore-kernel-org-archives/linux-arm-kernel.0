From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 7 Jun 2017 22:50:33 +0200
Subject: [PATCH 2/2] power: reset: at91-sama5d2_shdwc: fix clobber list
In-Reply-To: <20170531094915.3469-2-alexandre.belloni@free-electrons.com>
References: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
 <20170531094915.3469-2-alexandre.belloni@free-electrons.com>
Message-ID: <20170607205033.2cmzcrnb5dnp23ej@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 31, 2017 at 11:49:15AM +0200, Alexandre Belloni wrote:
> Assembly in at91_lpddr_poweroff has r0 in the clobber list but uses r6.

Thanks, queued.

-- Sebastian

> Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index 90b0b5a70ce5..55fce8b75245 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -132,7 +132,7 @@ static void at91_lpddr_poweroff(void)
>  		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
>  		  "r" (at91_shdwc->at91_shdwc_base),
>  		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
> -		: "r0");
> +		: "r6");
>  }
>  
>  static u32 at91_shdwc_debouncer_value(struct platform_device *pdev,
> -- 
> 2.11.0
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/eb7d0ff2/attachment.sig>
