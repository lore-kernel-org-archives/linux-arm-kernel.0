From: joe@perches.com (Joe Perches)
Date: Sun, 06 Jan 2013 18:06:02 -0800
Subject: [v3 PATCH 05/12] spi/atmel_spi: update the dt support
In-Reply-To: <1357523413-27209-6-git-send-email-wenyou.yang@atmel.com>
References: <1357523413-27209-1-git-send-email-wenyou.yang@atmel.com>
 <1357523413-27209-6-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1357524362.4940.16.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-01-07 at 09:50 +0800, Wenyou Yang wrote:
> To meet the different spi IP version of atmel SoC,
> add more compatible "atmel,at91rm9200-spi", "atmel,at91sam9260-spi"
> "atmel,at91sam9g45-spi", "atmel,at91sam9x5-spi" with different
> config and devtype.

trivial comment:

> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
[]
> @@ -230,11 +302,15 @@ struct atmel_spi_device {
>   * register, but I haven't checked that it exists on all chips, and
>   * this is cheaper anyway.
>   */
> -static bool atmel_spi_is_v2(void)
> +static bool atmel_spi_is_v2(struct atmel_spi *as)

There's a comment that needs updating above this now

>  {
> -	return !cpu_is_at91rm9200();
> +	if (as->pdata->version == 2)
> +		return true;
> +	else
> +		return false;

	return as->pdata->version == 2;

is rather more readable to me
