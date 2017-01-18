From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 18 Jan 2017 05:48:56 +0100
Subject: [PATCH v2 2/2] power/reset: at91-reset: remove leftover
 platform_device_id
In-Reply-To: <20170117230738.28257-2-alexandre.belloni@free-electrons.com>
References: <20170117230738.28257-1-alexandre.belloni@free-electrons.com>
 <20170117230738.28257-2-alexandre.belloni@free-electrons.com>
Message-ID: <20170118044856.iszgtnwjuzdtl2i6@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Wed, Jan 18, 2017 at 12:07:38AM +0100, Alexandre Belloni wrote:
> commit eacd8d09db7f ("power/reset: at91-reset: remove useless
> at91_reset_platform_probe()") removed non DT probe support but forgot to
> remove the now useless id_table. Do that now.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/power/reset/at91-reset.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index bb2588f0a4c7..b99769f8ab15 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -248,20 +248,12 @@ static int __exit at91_reset_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct platform_device_id at91_reset_plat_match[] = {
> -	{ "at91-sam9260-reset", (unsigned long)at91sam9260_restart },
> -	{ "at91-sam9g45-reset", (unsigned long)at91sam9g45_restart },
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(platform, at91_reset_plat_match);
> -
>  static struct platform_driver at91_reset_driver = {
>  	.remove = __exit_p(at91_reset_remove),
>  	.driver = {
>  		.name = "at91-reset",
>  		.of_match_table = at91_reset_of_match,
>  	},
> -	.id_table = at91_reset_plat_match,
>  };
>  module_platform_driver_probe(at91_reset_driver, at91_reset_probe);

Thanks, also queued into power-supply's for-next branch.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170118/baf17805/attachment.sig>
