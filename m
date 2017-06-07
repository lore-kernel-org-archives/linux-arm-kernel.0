From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 7 Jun 2017 22:50:17 +0200
Subject: [PATCH 1/2] power: reset: at91-poweroff: fix clobber list
In-Reply-To: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
References: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170607205017.a35lbn4q7eizq7rq@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 31, 2017 at 11:49:14AM +0200, Alexandre Belloni wrote:
> Assembly in at91_lpddr_poweroff has r0 in the clobber list but uses r6.
> 
> Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Thanks, queued.

-- Sebastian

> ---
>  drivers/power/reset/at91-poweroff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
> index c6c3beea72f9..c30c40193aaa 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -97,7 +97,7 @@ static void at91_lpddr_poweroff(void)
>  		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
>  		  "r" (at91_shdwc_base),
>  		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
> -		: "r0");
> +		: "r6");
>  }
>  
>  static int at91_poweroff_get_wakeup_mode(struct device_node *np)
> -- 
> 2.11.0
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/5e4304be/attachment.sig>
