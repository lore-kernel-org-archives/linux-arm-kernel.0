From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Oct 2014 13:08:59 +0100
Subject: [PATCH v3 3/4] Staging: iio: light: Added correct vendor-prefix
 for device isl29028
In-Reply-To: <1412682308-8784-4-git-send-email-darshanapadmadas@gmail.com>
References: <1412682308-8784-1-git-send-email-darshanapadmadas@gmail.com>
 <1412682308-8784-4-git-send-email-darshanapadmadas@gmail.com>
Message-ID: <20141007120859.GK24725@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 12:45:07PM +0100, Darshana Padmadas wrote:
> This patch adds the correct vendor-prefix for device isl29028 and
> maintains deprecated vendor-prefix found by checkpatch warning
> for older kernel releases.
> 
> Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

> ---
>  drivers/staging/iio/light/isl29028.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 6014625..60b02a8 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -537,7 +537,8 @@ static const struct i2c_device_id isl29028_id[] = {
>  MODULE_DEVICE_TABLE(i2c, isl29028_id);
>  
>  static const struct of_device_id isl29028_of_match[] = {
> -	{ .compatible = "isil,isl29028", },
> +	{ .compatible = "isl,isl29028", },
> +	{ .compatible = "isil,isl29028", }, /* deprecated, don't use */
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, isl29028_of_match);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
