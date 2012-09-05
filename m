From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 05 Sep 2012 12:40:17 +1000
Subject: [PATCH 13/25] macintosh/mediabay: add a const qualifier
In-Reply-To: <1343034810-3386-14-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-14-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1346812817.2257.23.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-07-23 at 11:13 +0200, Uwe Kleine-K?nig wrote:
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
> 
> 	drivers/macintosh/mediabay.c: In function 'media_bay_attach':
> 	drivers/macintosh/mediabay.c:589:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---

Ack all of these assuming you test built (I didn't). Do you need me to
carry any of this via the powerpc tree ?

Cheers,
Ben.

>  drivers/macintosh/mediabay.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
> index 831d751..54bf584 100644
> --- a/drivers/macintosh/mediabay.c
> +++ b/drivers/macintosh/mediabay.c
> @@ -63,7 +63,7 @@ struct media_bay_info {
>  	int				value_count;
>  	int				timer;
>  	struct macio_dev		*mdev;
> -	struct mb_ops*			ops;
> +	const struct mb_ops*		ops;
>  	int				index;
>  	int				cached_gpio;
>  	int				sleeping;
