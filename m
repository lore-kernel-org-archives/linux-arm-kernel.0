From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Oct 2014 16:47:33 +0200
Subject: [PATCH v2 3/4] regulator: fixed: Use gpio_is_valid
In-Reply-To: <1412776028-15655-4-git-send-email-mpa@pengutronix.de>
References: <1412776028-15655-1-git-send-email-mpa@pengutronix.de>
 <1412776028-15655-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20141013144733.GK27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 03:47:07PM +0200, Markus Pargmann wrote:
> Use gpio_is_valid instead of an explicit comparison with 0.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/regulator/fixed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> index 441a3e90e266..696f53cc1927 100644
> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c
> @@ -157,7 +157,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
>  
>  	drvdata->desc.fixed_uV = config->microvolts;
>  
> -	if (config->gpio >= 0) {
> +	if (gpio_is_valid(config->gpio)) {

Have you audited all users to ensure that they don't rely on zero being
ignored?  Right now we're sharing the core behaviour here so the same
issues apply to this platform data as apply to the core.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141013/eb0faf5b/attachment.sig>
