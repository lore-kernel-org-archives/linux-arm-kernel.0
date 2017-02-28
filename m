From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 28 Feb 2017 10:00:37 -0800
Subject: [PATCH v3 1/6] ARM: davinci: da8xx: allow having multiple
 pdata-quirks
In-Reply-To: <1487772805-19021-2-git-send-email-bgolaszewski@baylibre.com>
 (Bartosz Golaszewski's message of "Wed, 22 Feb 2017 15:13:20 +0100")
References: <1487772805-19021-1-git-send-email-bgolaszewski@baylibre.com>
 <1487772805-19021-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <m28toq19h6.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> We currently bail-out after applying a single quirk. We will want
> to reuse the function doing the vpif capture registration so remove
> the break; and continue iterating over the quirk array.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  arch/arm/mach-davinci/pdata-quirks.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
> index 5b57da4..36fb217 100644
> --- a/arch/arm/mach-davinci/pdata-quirks.c
> +++ b/arch/arm/mach-davinci/pdata-quirks.c
> @@ -23,7 +23,6 @@ static void pdata_quirks_check(struct pdata_init *quirks)
>  		if (of_machine_is_compatible(quirks->compatible)) {
>  			if (quirks->fn)
>  				quirks->fn();
> -			break;
>  		}
>  		quirks++;
>  	}
