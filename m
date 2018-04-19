From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 19 Apr 2018 17:07:59 +0200
Subject: [PATCH] drm/sun4i: Add missing frontend compatibles for A10,
 A13, A20 and A31
In-Reply-To: <20180419125638.11683-1-paul.kocialkowski@bootlin.com>
References: <20180419125638.11683-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180419150759.ldi676ejnbtmb27z@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 02:56:38PM +0200, Paul Kocialkowski wrote:
> Although frontend nodes are defined in the device-trees of the
> aforementioned platforms, there are no matching compatibles defined in
> the driver. This makes it impossible to probe the frontend on these
> platforms.
> 
> Adding the appropriate compatibles to the driver fixes the issue.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_frontend.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> index 85f75046712c..c5a3de11817d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -658,6 +658,10 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
>  };
>  
>  const struct of_device_id sun4i_frontend_of_table[] = {
> +	{ .compatible = "allwinner,sun7i-a10-display-frontend" },
> +	{ .compatible = "allwinner,sun7i-a13-display-frontend" },
> +	{ .compatible = "allwinner,sun7i-a20-display-frontend" },
> +	{ .compatible = "allwinner,sun7i-a31-display-frontend" },

Most of these compatibles are wrong, so it won't really work :)

If you only tested it on the A20, just add it. We didn't add all of
them because there's some slight variations between the generations
that are not yet taken into account.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180419/0933ea7f/attachment.sig>
